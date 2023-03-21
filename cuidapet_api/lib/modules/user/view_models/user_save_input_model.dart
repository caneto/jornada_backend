
import 'package:cuidapet_api/application/helpers/resqust_mapping.dart';

class UserSaveInputModel extends RequestMapping {
  late String email;
  late String password;
  int? supplierId;
  UserSaveInputModel(String dataRequest) : super(dataRequest);
  
  @override
  void map() {
    email = data['email'];
    password = data['password'];
  }
}
