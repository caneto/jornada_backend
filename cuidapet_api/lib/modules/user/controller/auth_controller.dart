import 'dart:async';
import 'dart:convert';

import 'package:cuidapet_api/application/exceptions/request_validation_exception.dart';
import 'package:cuidapet_api/application/exceptions/user_exists_exception.dart';
import 'package:cuidapet_api/application/exceptions/user_notfound_exception.dart';
import 'package:cuidapet_api/application/helpers/jwt_helper.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/user.dart';
import 'package:cuidapet_api/modules/user/view_models/login_view_model.dart';
import 'package:cuidapet_api/modules/user/view_models/user_confirm_input_model.dart';
import 'package:cuidapet_api/modules/user/view_models/user_save_input_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:cuidapet_api/modules/user/service/i_user_service.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  IUserService userService;
  ILogger log;

  AuthController({
    required this.userService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> login(Request request) async {
    try {
      final loginViewModel = LoginViewModel(await request.readAsString());

      //var user = User();
      User user;
      
      if (!loginViewModel.socialLogin) {
        loginViewModel.loginEmailValidate();
        user = await userService.loginWithEmailPassword(loginViewModel.login,
            loginViewModel.password!, loginViewModel.supplierUser);
      } else {
        loginViewModel.loginSocialValidate();
        // Social Login (Facebook, google, apple, etc...)
        user = await userService.loginWithSocial(
            loginViewModel.login,
            loginViewModel.avatar,
            loginViewModel.socialType!,
            loginViewModel.socialKey!);
        
      }

      return Response.ok(jsonEncode({
        'access_token': JwtHelper.generateJWT(user.id!, user.supplierId),
      }));
    } on UserNotfoundException {
      return Response.forbidden(
          jsonEncode({'message': 'Usuário ou senha inváldos'}));
    } on RequestValidationException catch (e, s) {
      log.error('Erro de parametros obrigatorios não enviados', e, s);
      return Response(400, body: jsonEncode(e.errors));
    } catch (e, s) {
      log.error('Erro ao fazer login', e, s);
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Erro ao realizar login',
      }));
    }
  }

  @Route.post('/register')
  Future<Response> saveUser(Request request) async {
    try {
      final userModel = UserSaveInputModel(await request.readAsString());
      await userService.createUser(userModel);

      return Response.ok(
          jsonEncode({'message': 'cadastro realizado com sucesso'}));
    } on UserExistsException {
      return Response(400,
          body: jsonEncode(
              {'message': 'Usuário já cadastrado na base de dados'}));
    } catch (e, s) {
      log.error('Erro ao fazer login', e, s);
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Erro ao realizar login',
      }));
    }
  }

  @Route('PATCH', '/confirm')
  Future<Response> confirmLogin(Request request) async {
    final user = int.parse(request.headers['user']!);
    final supplier = int.tryParse(request.headers['suppller'] ?? '');
    final token = JwtHelper.generateJWT(user, supplier).replaceAll('Bearer ', '');

    final inputModel = UserConfirmInputModel(userId: user, accessToken: token, data: await request.readAsString());
    final refreshToken = await userService.confirmLogin(inputModel);

     return Response.ok(jsonEncode({
      'access_token': 'Bearer $token',
      'refresh_token': refreshToken
     }));
  }

  Router get router => _$AuthControllerRouter(this);
}
