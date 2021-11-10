import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductCategoryRepository {
  Future<Either<Failure, List<CategoriesEntities>>> getCategories();
}
