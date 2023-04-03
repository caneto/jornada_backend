
import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:cuidapet_api/modules/user/controller/user_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controller/auth_controller.dart';


class UserRouter implements IRouter {
  @override
  void Configure(Router router) {

    final authController = GetIt.I.get<AuthController>();
    final userController = GetIt.I.get<UserController>();
    
    router.mount('/auth/', authController.router);
    router.mount('/user/', userController.router);
  }
  
}