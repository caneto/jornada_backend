import 'package:cuidapet_api/entities/category.dart';
import 'package:cuidapet_api/modules/categories/data/i_categories_repository.dart';
import 'package:injectable/injectable.dart';

import './i_categories_service.dart';

@LazySingleton(as: ICategoriesService)
class ICategoriesServiceImpl implements ICategoriesService {
  ICategoriesRepository repository;

  ICategoriesServiceImpl({
    required this.repository,
  });

  @override
  Future<List<Category>> findAll() => repository.findAll();
}