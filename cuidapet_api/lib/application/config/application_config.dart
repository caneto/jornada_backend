import 'package:cuidapet_api/application/config/database_connection_configuration.dart';
import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';

class ApplicationConfig {

  late DotEnv env;

  Future<void> loadConfigApplication() async {
    await _loadEnv();
    _loadDatabaseConfig();
  }

  Future<void> _loadEnv() async {
     env = DotEnv(includePlatformEnvironment: true)..load();
  }

  void _loadDatabaseConfig() {
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!,
      user: env['DATABASE_USER'] ?? env['databaseUser']!,
      port: int.tryParse(env['DATABASE_PORT`'] ?? env['databasePort']!) ?? 0,
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!,
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
    );

    GetIt.I.registerSingleton(databaseConfig);
  }
}
