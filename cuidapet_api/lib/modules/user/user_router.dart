
import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controller/auth_controller.dart';


class UserRouter implements IRouter {
  @override
  void Configure(Router router) {

    final authController = GetIt.I.get<AuthController>();
    
    router.mount('/auth/', authController.router);
  }
  
}