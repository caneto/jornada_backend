import 'package:cuidapet_api/modules/schedule/view_models/schedule_save_input_model.dart';

import '../../../entities/schedule.dart';

abstract class IScheduleService {
  Future<void> scheduleService(ScheduleSaveInputModel model);
  Future<void> changeStatus(String status, int scheduleId);
  Future<List<Schedule>> findAllSchedulesByUser(int userId);
}