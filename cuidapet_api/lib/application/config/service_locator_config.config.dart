// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cuidapet_api/application/config/database_connection_configuration.dart'
    as _i5;
import 'package:cuidapet_api/application/database/i_database_connection.dart'
    as _i3;
import 'package:cuidapet_api/application/database/i_database_connection_impl.dart'
    as _i4;
import 'package:cuidapet_api/application/logger/i_logger.dart' as _i8;
import 'package:cuidapet_api/modules/categories/controller/categories_controller.dart'
    as _i22;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository.dart'
    as _i15;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository_impl.dart'
    as _i16;
import 'package:cuidapet_api/modules/categories/service/i_categories_service.dart'
    as _i17;
import 'package:cuidapet_api/modules/categories/service/i_categories_service_impl.dart'
    as _i18;
import 'package:cuidapet_api/modules/supplier/controller/supplier_controller.dart'
    as _i21;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository.dart'
    as _i6;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository_impl.dart'
    as _i7;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service.dart'
    as _i19;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service_impl.dart'
    as _i20;
import 'package:cuidapet_api/modules/user/controller/auth_controller.dart'
    as _i14;
import 'package:cuidapet_api/modules/user/controller/user_controller.dart'
    as _i13;
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart' as _i9;
import 'package:cuidapet_api/modules/user/data/i_user_repository_impl.dart'
    as _i10;
import 'package:cuidapet_api/modules/user/service/i_user_service.dart' as _i11;
import 'package:cuidapet_api/modules/user/service/i_user_service_impl.dart'
    as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
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
    gh.lazySingleton<_i6.ISupplierRepository>(() => _i7.ISupplierRepositoryImpl(
          connection: gh<_i3.IDatabaseConnection>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i9.IUserRepository>(() => _i10.IUserRepositoryImpl(
          connection: gh<_i3.IDatabaseConnection>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i11.IUserService>(() => _i12.IUserServiceImpl(
          userRepository: gh<_i9.IUserRepository>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i13.UserController>(() => _i13.UserController(
          userService: gh<_i11.IUserService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i14.AuthController>(() => _i14.AuthController(
          userService: gh<_i11.IUserService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.lazySingleton<_i15.ICategoriesRepository>(
        () => _i16.ICategoryRepositoryImpl(
              connection: gh<_i3.IDatabaseConnection>(),
              log: gh<_i8.ILogger>(),
            ));
    gh.lazySingleton<_i17.ICategoriesService>(() => _i18.ICategoriesServiceImpl(
        repository: gh<_i15.ICategoriesRepository>()));
    gh.lazySingleton<_i19.ISupplierService>(() => _i20.ISupplierServiceImpl(
          repository: gh<_i6.ISupplierRepository>(),
          userService: gh<_i11.IUserService>(),
        ));
    gh.factory<_i21.SupplierController>(() => _i21.SupplierController(
          service: gh<_i19.ISupplierService>(),
          log: gh<_i8.ILogger>(),
        ));
    gh.factory<_i22.CategoriesController>(() =>
        _i22.CategoriesController(service: gh<_i17.ICategoriesService>()));
    return this;
  }
}
