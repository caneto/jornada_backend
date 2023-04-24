import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

import 'controller/schedule_controller.dart';

class ScheduleRouter implements IRouter {

  @override
  void Configure(Router router) {
    final scheduleController = GetIt.I.get<ScheduleController>();
    router.mount('/schedules/', scheduleController.router);
  }
  
  
}
