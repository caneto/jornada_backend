import 'dart:async';
import 'dart:convert';

import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';


part 'schedule_controller.g.dart';

@Injectable()
class ScheduleController {
  
  Router get router => _$ScheduleControllerRouter(this);
}
