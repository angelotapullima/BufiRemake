import 'package:bufi_remake/features/data/models/Explorer/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/data/models/Explorer/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/entities/Explorer/categoriesEntities.dart';
import 'package:dartz/dartz.dart';

abstract class ExplorerRepository {
  Future<Either<Failure, List<CategoriesEntities>>> getCategories();
  Future<Either<Failure, List<SubCategoriesModel>>> getSubCategories(String ? idCategory);
  Future<Either<Failure, List<ItemSubCategoriesModel>>> getitemSubCategories(String ? idSubCategory);
}
