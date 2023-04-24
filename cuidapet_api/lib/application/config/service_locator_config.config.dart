// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/controller/categories_controller.dart' as _i27;
import '../../modules/categories/data/i_categories_repository.dart' as _i20;
import '../../modules/categories/data/i_categories_repository_impl.dart'
    as _i21;
import '../../modules/categories/service/i_categories_service.dart' as _i22;
import '../../modules/categories/service/i_categories_service_impl.dart'
    as _i23;
import '../../modules/schedule/controller/schedule_controller.dart' as _i17;
import '../../modules/schedule/data/i_schedule_repository.dart' as _i6;
import '../../modules/schedule/data/i_schedule_repository_impl.dart' as _i7;
import '../../modules/schedule/service/i_schedule_service.dart' as _i9;
import '../../modules/schedule/service/i_schedule_service_impl.dart' as _i10;
import '../../modules/supplier/controller/supplier_controller.dart' as _i26;
import '../../modules/supplier/data/i_supplier_repository.dart' as _i11;
import '../../modules/supplier/data/i_supplier_repository_impl.dart' as _i12;
import '../../modules/supplier/service/i_supplier_service.dart' as _i24;
import '../../modules/supplier/service/i_supplier_service_impl.dart' as _i25;
import '../../modules/user/controller/auth_controller.dart' as _i19;
import '../../modules/user/controller/user_controller.dart' as _i18;
import '../../modules/user/data/i_user_repository.dart' as _i13;
import '../../modules/user/data/i_user_repository_impl.dart' as _i14;
import '../../modules/user/service/i_user_service.dart' as _i15;
import '../../modules/user/service/i_user_service_impl.dart' as _i16;
import '../database/i_database_connection.dart' as _i3;
import '../database/i_database_connection_impl.dart' as _i4;
import '../logger/i_logger.dart' as _i8;
import 'database_connection_configuration.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.IDatabaseConnection>(() =>
        _i4.IDatabaseConnectionImpl(gh<_i5.DatabaseConnectionConfiguration>()));
    gh.lazySingleton<_i6.IScheduleRepository>(() => _i7.IScheduleRepositoryImpl(
          connection: gh<_i3.IDatabaseConnection>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i9.IScheduleService>(() =>
        _i10.IScheduleServiceImpl(repository: gh<_i6.IScheduleRepository>()));
    gh.lazySingleton<_i11.ISupplierRepository>(
        () => _i12.ISupplierRepositoryImpl(
              connection: gh<_i3.IDatabaseConnection>(),
              log: gh<_i8.ILogger>(),
            ));
    gh.lazySingleton<_i13.IUserRepository>(() => _i14.IUserRepositoryImpl(
          connection: gh<_i3.IDatabaseConnection>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i15.IUserService>(() => _i16.IUserServiceImpl(
          userRepository: gh<_i13.IUserRepository>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i17.ScheduleController>(() => _i17.ScheduleController(
          service: gh<_i9.IScheduleService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i18.UserController>(() => _i18.UserController(
          userService: gh<_i15.IUserService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i19.AuthController>(() => _i19.AuthController(
          userService: gh<_i15.IUserService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i20.ICategoriesRepository>(
        () => _i21.ICategoryRepositoryImpl(
              connection: gh<_i3.IDatabaseConnection>(),
              log: gh<_i8.ILogger>(),
            ));
    gh.lazySingleton<_i22.ICategoriesService>(() => _i23.ICategoriesServiceImpl(
        repository: gh<_i20.ICategoriesRepository>()));
    gh.lazySingleton<_i24.ISupplierService>(() => _i25.ISupplierServiceImpl(
          repository: gh<_i11.ISupplierRepository>(),
          userService: gh<_i15.IUserService>(),
        ));
    gh.factory<_i26.SupplierController>(() => _i26.SupplierController(
          service: gh<_i24.ISupplierService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i27.CategoriesController>(() =>
        _i27.CategoriesController(service: gh<_i22.ICategoriesService>()));
    return this;
  }
}
