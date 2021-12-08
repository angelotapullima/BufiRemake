import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/productosPorItemSubcategoria/proxItemSub_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/productosPorItemSubcategoria/proxItemSub_remote_datasource.dart';
import 'package:bufi_remake/features/data/models/Explorer/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/productosPorItemSubcategoria/proxItemSub_repository.dart';
import 'package:dartz/dartz.dart';

class ProXItemSubRepositoryImpl implements ProXItemSubRepository {
  final ProXItemSubLocalDataSource? proXItemSubLocalDataSource;
  final ProXItemSubRemoteDataSource? proXItemSubRemoteDataSource;
  final NetworkInfo? networkInfo;

  ProXItemSubRepositoryImpl({
    required this.proXItemSubLocalDataSource,
    required this.proXItemSubRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductoModel>>> getProductosPorItemSubcategoria(String? idItemSubCat) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteListCategory = await proXItemSubRemoteDataSource!.getProductsForItemSub(idItemSubCat!);

        return Right(remoteListCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListCategory = await proXItemSubLocalDataSource!.getProductosPorItemSubcategoria(idItemSubCat!);
        return Right(localListCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
