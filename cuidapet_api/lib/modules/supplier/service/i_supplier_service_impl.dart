import 'package:injectable/injectable.dart';

import 'package:cuidapet_api/dtos/supplier_nearby_me_dto.dart';
import 'package:cuidapet_api/entities/supplier_service.dart';

import '../../../entities/category.dart';
import '../../../entities/supplier.dart';
import '../../user/service/i_user_service.dart';
import '../../user/view_models/user_save_input_model.dart';
import '../data/i_supplier_repository.dart';
import '../view_models/create_supplier_user_view_model.dart';
import '../view_models/supplier_update_input_model.dart';
import './i_supplier_service.dart';

@LazySingleton(as: ISupplierService)
class ISupplierServiceImpl implements ISupplierService {
  final ISupplierRepository repository;
  final IUserService userService;

  static const DISTANCE = 5;

  ISupplierServiceImpl({
    required this.repository,
    required this.userService,
  });

  @override
  Future<List<SupplierNearbyMeDTO>> findNearByMe(double lat, double lng) =>
      repository.findNearByPosition(lat, lng, DISTANCE);

  @override
  Future<Supplier?> findById(int id) => repository.findById(id);

  @override
  Future<List<SupplierService>> findServicesBySupplier(int supplierId) =>
      repository.findServicesBySupplierId(supplierId);

  @override
  Future<bool> checkUserEmailExists(String email) =>
      repository.checkUserEmailExists(email);

  @override
  Future<void> createUserSupplier(CreateSupplierUserViewModel model) async {
    final supplierEntity = Supplier(
        name: model.supplierName, category: Category(id: model.category));

    final supplierId = await repository.saveSupplier(supplierEntity);

    final userInputModel = UserSaveInputModel(
      email: model.email,
      password: model.password,
      supplierId: supplierId,
    );

    await userService.createUser(userInputModel);
  }
  
  @override
  Future<Supplier> update(SupplierUpdateInputModel model) async {
    var supplier = Supplier(
        id: model.supplierId,
        name: model.name,
        address: model.address,
        lat: model.lat,
        lng: model.lng,
        logo: model.logo,
        phone: model.phone,
        category: Category(id: model.categoryId));

    return await repository.update(supplier);
  }    
}
