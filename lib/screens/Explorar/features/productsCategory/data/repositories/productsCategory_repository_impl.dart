import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/productsCategory_local_datasource.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/productsCategory_remote_datasource.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/repositories/productsCategory_repository.dart';
import 'package:dartz/dartz.dart';

class ProductCategoryRepositoryImpl implements ProductCategoryRepository {
  final ProductCategoryLocalDataSource? productCategoryLocalDataSource;
  final ProductsCategoryRemoteDataSource? productsCategoryRemoteDataSource;
  final NetworkInfo? networkInfo;

  ProductCategoryRepositoryImpl({
    required this.productCategoryLocalDataSource,
    required this.productsCategoryRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoriesEntities>>> getCategories() async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListCategory = await productsCategoryRemoteDataSource!.getCategories();
        return Right(remoteListCategory);
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
}
