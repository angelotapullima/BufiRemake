/* import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/Explorar/Productos/productosXItemSubcategoria/data/datasources/proxItemSub_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productosXItemSubcategoria/data/datasources/proxItemSub_remote_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productosXItemSubcategoria/data/models/productoModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productosXItemSubcategoria/domain/repositories/proxItemSub_repository.dart';
import 'package:dartz/dartz.dart';

class ProXItemSubRepositoryImpl implements ProXItemSubRepository {
  final ProXItemSubLocalDataSourceImpl? proXItemSubLocalDataSourceImpl;
  final ProXItemSubRemoteDataSource? proXItemSubRemoteDataSource;
  final NetworkInfo? networkInfo;

  ProXItemSubRepositoryImpl({
    required this.proXItemSubLocalDataSourceImpl,
    required this.proXItemSubRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoria(String? idItemSubCat) async {
    try {
      final localListItemSubCategory = await proXItemSubLocalDataSourceImpl!.getProductosPorItemSubcategoria(idItemSubCat!);
      return Right(localListItemSubCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoriaPaginado(String? idItemSubCat, String? pagina) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListCategory = await proXItemSubRemoteDataSource!.getCategories();

        return Right([]);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListCategory = await proXItemSubLocalDataSourceImpl!.getProductosPorItemSubcategoria(idItemSubCat!);
        return Right(localListCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
 */