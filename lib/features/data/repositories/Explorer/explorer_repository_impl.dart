
import 'package:bufi_remake/features/data/datasources/Explorer/Category/explorer_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/Category/explorer_remote_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/ItemSubcategory/itemSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/Subcategory/subCategory_local_datasource.dart';
import 'package:bufi_remake/features/data/models/Explorer/Category/categoriesModel.dart';
import 'package:bufi_remake/features/data/models/Explorer/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/data/models/Explorer/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/features/domain/entities/Explorer/categoriesEntities.dart';
import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/explorer_repository.dart';
import 'package:dartz/dartz.dart';

class ExplorerRepositoryImpl implements ExplorerRepository {
  final ExplorarLocalDataSource? explorarLocalDataSource;
  final SubCategoryLocalDatasource? subCategoryLocalDatasource;
  final ItemSubCategoryLocalDataSource? itemSubCategoryLocalDataSource;
  final ExplorarRemoteDataSource? explorarRemoteDataSource;
  final NetworkInfo? networkInfo;

  ExplorerRepositoryImpl({
    required this.explorarLocalDataSource,
    required this.itemSubCategoryLocalDataSource,
    required this.subCategoryLocalDatasource,
    required this.explorarRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoriesEntities>>> getCategories() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListCategory = await explorarRemoteDataSource!.getCategories();

        for (var i = 0; i < remoteListCategory.listCategories.length; i++) {
          var data = remoteListCategory.listCategories[i];

          CategoriesModel cat = CategoriesModel(
            idCategory: data.idCategory,
            categoryName: data.categoryName,
            categoryImage: data.categoryImage,
            categoryEstado: data.categoryEstado,
          );

          await explorarLocalDataSource!.insertCategory(cat);
        }

        for (var i = 0; i < remoteListCategory.listSubCategories.length; i++) {
          var data = remoteListCategory.listSubCategories[i];
          SubCategoriesModel subCat = SubCategoriesModel(
            idSubCategory: data.idSubCategory,
            nameSubCategory: data.subCategoryName,
            idCategory: data.idCategory,
          );

          await subCategoryLocalDatasource!.insertSubCategory(subCat);
        }

        for (var i = 0; i < remoteListCategory.listItemSubCategories.length; i++) {
          var data = remoteListCategory.listItemSubCategories[i];

          ItemSubCategoriesModel itemSubCat = ItemSubCategoriesModel(
            idItemSubCategory: data.idItemSubCategory,
            nameItemSubCategory: data.nameItemSubCategory,
            imagenItemSubCategory: data.imagenItemSubCategory,
            estadoItemSubCategory: data.estadoItemSubCategory,
            idSubCategory: data.idSubCategory,
          );

          await itemSubCategoryLocalDataSource!.insertItemSubCategory(itemSubCat);
        }

        return Right(remoteListCategory.listCategories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListCategory = await explorarLocalDataSource!.getCategories();
        return Right(localListCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SubCategoriesModel>>> getSubCategories(String? idCategory) async {
    try {
      final localListSubCategory = await subCategoryLocalDatasource!.getSubCategories(idCategory!);
      return Right(localListSubCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemSubCategoriesModel>>> getitemSubCategories(String? idSubCategory)async {
     try {
      final localListItemSubCategory = await itemSubCategoryLocalDataSource!.getItemSubCategories(idSubCategory!);
      return Right(localListItemSubCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
