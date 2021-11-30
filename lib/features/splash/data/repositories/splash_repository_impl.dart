





import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:bufi_remake/features/splash/domain/repositories/splash_repository.dart';
import 'package:dartz/dartz.dart';

class SplashRepositoryImpl implements SplashRepository {
  
  final SplashLocalDataSource? splashLocalDataSource;
  final NetworkInfo? networkInfo;

  SplashRepositoryImpl({required this.splashLocalDataSource, required this.networkInfo});

   

  @override
  Future<Either<Failure, String>> fetchCachedToken() async {
    try {
      final localData = await splashLocalDataSource!.getLastToken();
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}