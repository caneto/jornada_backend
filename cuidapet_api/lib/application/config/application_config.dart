
import 'package:dotenv/dotenv.dart';

class ApplicationConfig {
  Future<void> loadConfigApplication() async {
    await _loadEnv();
  }
  
  Future<void> _loadEnv() async => DotEnv(includePlatformEnvironment: true)..load();
}

