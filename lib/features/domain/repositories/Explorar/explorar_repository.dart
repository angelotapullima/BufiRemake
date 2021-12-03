import 'package:bufi_remake/features/data/models/Explorar/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/data/models/Explorar/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/entities/Explorar/categoriesEntities.dart';
import 'package:dartz/dartz.dart';

abstract class ExplorarRepository {
  Future<Either<Failure, List<CategoriesEntities>>> getCategories();
  Future<Either<Failure, List<SubCategoriesModel>>> getSubCategories(String ? idCategory);
  Future<Either<Failure, List<ItemSubCategoriesModel>>> getitemSubCategories(String ? idSubCategory);
}
