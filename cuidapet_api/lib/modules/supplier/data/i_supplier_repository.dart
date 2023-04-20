import '../../../dtos/supplier_nearby_me_dto.dart';
import '../../../entities/supplier.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearbyMeDTO>> findNearByPosition(
      double lat, double lng, int distance);
      
   Future<Supplier?> findById(int id);    
}
