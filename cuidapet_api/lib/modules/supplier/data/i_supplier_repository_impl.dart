import 'package:cuidapet_api/dtos/supplier_nearby_me_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../application/database/i_database_connection.dart';
import '../../../application/exceptions/database_exception.dart';
import '../../../application/logger/i_logger.dart';
import './i_supplier_repository.dart';

@LazySingleton(as: ISupplierRepository)
class ISupplierRepositoryImpl implements ISupplierRepository {
  IDatabaseConnection connection;
  ILogger log;

  ISupplierRepositoryImpl({
    required this.connection,
    required this.log,
  });

  @override
  Future<List<SupplierNearbyMeDTO>> findNearByPosition(
      double lat, double lng, int distance) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query =
          ''' 
        SELECT f.id, f.nome, f.logo, f.categorias_fornecedor_id,
          (6371 *
            acos(
                            cos(radians($lat)) *
                            cos(radians(ST_X(f.latlng))) *
                            cos(radians($lng) - radians(ST_Y(f.latlng))) +
                            sin(radians($lat)) *
                            sin(radians(ST_X(f.latlng)))
                )) AS distancia
            FROM fornecedor f
            HAVING distancia <= $distance
            Order by distancia;
      ''';

      final result = await conn.query(query);
      return result
          .map(
            (f) => SupplierNearbyMeDTO(
                id: f['id'],
                name: f['nome'],
                logo: (f['logo'] as Blob?)?.toString(),
                distance: f['distancia'],
                categoryId: f['categorias_fornecedor_id']),
          )
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar fornecedores perto de mim', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
