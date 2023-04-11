
// ignore_for_file: implementation_imports

import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:cuidapet_api/modules/supplier/controller/supplier_controller.dart';

class SupplierRouter implements IRouter {

  @override
  void Configure(Router router) {
    final supplierController = GetIt.I.get<SupplierController>();
    router.mount('/suppliers/', supplierController.router);
  }
  
}