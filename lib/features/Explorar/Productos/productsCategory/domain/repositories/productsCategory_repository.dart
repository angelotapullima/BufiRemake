import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProductCategoryRepository {
  Future<Either<Failure, List<CategoriesEntities>>> getCategories();
  Future<Either<Failure, List<SubCategoriesModel>>> getSubCategories(String ? idCategory);
  Future<Either<Failure, List<ItemSubCategoriesModel>>> getitemSubCategories(String ? idSubCategory);
}
