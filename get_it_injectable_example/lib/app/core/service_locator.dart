
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/* void configureDependencies() {
  final getIt = GetIt.I;

  getIt.registerFactory(() => RandomFactoryModel());
  getIt.registerSingleton(RandomSingletonModel());
  getIt.registerLazySingleton(() => RandomLazySingletonModel());
} */

import 'service_locator.config.dart';

final getIt = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', // default  
  preferRelativeImports: true, // default  
  asExtension: true, // default  
)  
void configureDependencies() => getIt.init();  