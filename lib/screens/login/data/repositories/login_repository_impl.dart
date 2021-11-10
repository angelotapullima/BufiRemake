import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/screens/login/data/datasources/login_local_datasource.dart';
import 'package:bufi_remake/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:bufi_remake/screens/login/domain/entities/login.dart';
import 'package:bufi_remake/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource? remoteDataSource;
  final LoginLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  LoginRepositoryImpl({required this.localDataSource, required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Login>> loginUser2(String? email, String? password) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteData = await remoteDataSource!.loginUser3(email, password);

        if (remoteData.code == '1') {
          localDataSource!.guardarPrefs('cU', remoteData.loginEntities!.cU);
          localDataSource!.guardarPrefs('idBufipay', remoteData.loginEntities!.idBufipay);
          localDataSource!.guardarPrefs('n', remoteData.loginEntities!.n);
          localDataSource!.guardarPrefs('uE', remoteData.loginEntities!.uE);
          localDataSource!.guardarPrefs('uI', remoteData.loginEntities!.uI);
          localDataSource!.guardarPrefs('pC', remoteData.loginEntities!.pC);
          localDataSource!.guardarPrefs('pU', remoteData.loginEntities!.pU);
          localDataSource!.guardarPrefs('pN', remoteData.loginEntities!.pN);
          localDataSource!.guardarPrefs('pP', remoteData.loginEntities!.pP);
          localDataSource!.guardarPrefs('pM', remoteData.loginEntities!.pM);
          localDataSource!.guardarPrefs('pS', remoteData.loginEntities!.pS);
          localDataSource!.guardarPrefs('pD', remoteData.loginEntities!.pD);
          localDataSource!.guardarPrefs('ru', remoteData.loginEntities!.ru);
          localDataSource!.guardarPrefs('rn', remoteData.loginEntities!.rn);
          localDataSource!.guardarPrefs('tn', remoteData.loginEntities!.tn);
          return Right(remoteData);
        } else {
          return Left(ApiError(code: remoteData.code.toString(), message: remoteData.message.toString()));
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> fetchCachedToken() async {
    try {
      final localData = await localDataSource!.getLastToken();
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
