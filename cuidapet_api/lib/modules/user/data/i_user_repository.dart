import 'package:cuidapet_api/entities/user.dart';

abstract class IUserRepository {
  Future<User> createUser(User user);
  Future<User> loginWithEmailPassword(String email, String password, bool supplierUser);  
  Future<User> loginEmailSocialKey(String email, String socialKey, String socialType);
  Future<void> updateUserDeviceTokenAndRefreshToken(User user);
}