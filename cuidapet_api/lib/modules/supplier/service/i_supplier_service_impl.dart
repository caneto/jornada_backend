import 'package:cuidapet_api/dtos/supplier_nearby_me_dto.dart';
import 'package:injectable/injectable.dart';

import '../../user/service/i_user_service.dart';
import '../data/i_supplier_repository.dart';
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
}
