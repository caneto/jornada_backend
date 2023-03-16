
import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfigure {
  
  final Router _router;
  final List<IRouter> _routers = [];

  RouterConfigure(this._router);

  void configure() => _routers.forEach((r) => r.Configure(_router));
}