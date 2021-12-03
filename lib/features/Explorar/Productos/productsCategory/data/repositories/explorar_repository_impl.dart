import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Category/explorar_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Category/explorar_remote_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/ItemSubcategory/productsItemSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Subcategory/productsSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/categoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/repositories/explorar_repository.dart';
import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/network/network_info.dart';import 'package:bufi_remake/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class ExplorarRepositoryImpl implements ExplorarRepository {
  final ExplorarLocalDataSource? productCategoryLocalDataSource;
  final ProductSubCategoryLocalDatasource? productSubCategoryLocalDataSource;
  final ProductItemSubCategoryLocalDataSource? productItemSubCategoryLocalDataSource;
  final ExplorarRemoteDataSource? productsCategoryRemoteDataSource;
  final NetworkInfo? networkInfo;

  ExplorarRepositoryImpl({
    required this.productCategoryLocalDataSource,
    required this.productItemSubCategoryLocalDataSource,
    required this.productSubCategoryLocalDataSource,
    required this.productsCategoryRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoriesEntities>>> getCategories() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListCategory = await productsCategoryRemoteDataSource!.getCategories();

        for (var i = 0; i < remoteListCategory.listCategories.length; i++) {
          var data = remoteListCategory.listCategories[i];

          CategoriesModel cat = CategoriesModel(
            idCategory: data.idCategory,
            categoryName: data.categoryName,
            categoryImage: data.categoryImage,
            categoryEstado: data.categoryEstado,
          );

          await productCategoryLocalDataSource!.insertCategory(cat);
        }

        for (var i = 0; i < remoteListCategory.listSubCategories.length; i++) {
          var data = remoteListCategory.listSubCategories[i];
          SubCategoriesModel subCat = SubCategoriesModel(
            idSubCategory: data.idSubCategory,
            nameSubCategory: data.subCategoryName,
            idCategory: data.idCategory,
          );

          await productSubCategoryLocalDataSource!.insertSubCategory(subCat);
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

          await productItemSubCategoryLocalDataSource!.insertItemSubCategory(itemSubCat);
        }

        return Right(remoteListCategory.listCategories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListCategory = await productCategoryLocalDataSource!.getCategories();
        return Right(localListCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SubCategoriesModel>>> getSubCategories(String? idCategory) async {
    try {
      final localListSubCategory = await productSubCategoryLocalDataSource!.getSubCategories(idCategory!);
      return Right(localListSubCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemSubCategoriesModel>>> getitemSubCategories(String? idSubCategory)async {
     try {
      final localListItemSubCategory = await productItemSubCategoryLocalDataSource!.getItemSubCategories(idSubCategory!);
      return Right(localListItemSubCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}