import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../application/logger/i_logger.dart';
import '../../../entities/supplier.dart';
import '../service/i_supplier_service.dart';

part 'supplier_controller.g.dart';

@Injectable()
class SupplierController {
  ISupplierService service;
  ILogger log;

  SupplierController({
    required this.service,
    required this.log,
  });

  @Route.get('/')
  Future<Response> findNearByMe(Request request) async {
    try {
      final lat = double.tryParse(request.url.queryParameters['lat'] ?? '');
      final lng = double.tryParse(request.url.queryParameters['lng'] ?? '');

      if (lat == null || lng == null) {
        return Response(
          400,
          body: jsonEncode({
            'message': 'Latitude e logitude obrigatórios',
          }),
        );
      }

      final suppliers = await service.findNearByMe(lat, lng);
      final result = suppliers
          .map((s) => {
                'id': s.id,
                'name': s.name,
                'logo': s.logo,
                'distance': s.distance,
                'category': s.categoryId,
              })
          .toList();

      return Response.ok(jsonEncode(result));
    } catch (e, s) {
      log.error('Erro ao buscar fornecedores perto de mim', e, s);
      return Response.internalServerError(
          body: jsonEncode(
              {'message': 'Erro ao buscar fornecedores perto de mim'}));
    }
  }

  @Route.get('/<id|[0-9]+>')
  Future<Response> findById(Request request, String id) async {
    final supplier = await service.findById(int.parse(id));

    if (supplier == null) {
      return Response.ok(jsonEncode({}));
    }

    return Response.ok(_supplierMapper(supplier));
  }

 @Route.get('/<supplierId|[0-9]+>/services')
  Future<Response> findServicesBySupplierId(
      Request request, String supplierId) async {
    try {
      final supplierServices =
          await service.findServicesBySupplier(int.parse(supplierId));

      final result = supplierServices
          .map((e) => {
                'id': e.id,
                'supplier_id': e.supplierId,
                'name': e.name,
                'price': e.price
              })
          .toList();

      return Response.ok(jsonEncode(result));
    } catch (e, s) {
      log.error('Erro ao buscar servicos', e, s);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao buscar servicos'}));
    }
  }



  String _supplierMapper(Supplier supplier) {
    return jsonEncode({
      'id': supplier.id,
      'name': supplier.name,
      'logo': supplier.logo,
      'address': supplier.address,
      'phone': supplier.phone,
      'latitude': supplier.lat,
      'longitude': supplier.lng,
      'category': {
        'id': supplier.category?.id,
        'name': supplier.category?.name,
        'type': supplier.category?.type,
      },
    });
  }

  Router get router => _$SupplierControllerRouter(this);
}