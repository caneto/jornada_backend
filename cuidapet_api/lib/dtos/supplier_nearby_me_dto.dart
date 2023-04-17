
class SupplierNearbyMeDTO {
  
  final int id;
  final String name;
  final String? logo;
  final double distance;
  final int categoryId;

  SupplierNearbyMeDTO({
    required this.id,
    required this.name,
    this.logo,
    required this.distance,
    required this.categoryId,
  });
  
}
