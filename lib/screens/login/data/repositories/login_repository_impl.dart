import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:bufi_remake/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;

  LoginRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, String>> loginUser2(
      String? email, String? password) async {
    if (await networkInfo!.isConnected) {
      try {
        final remoteData = await remoteDataSource!.loginUser3(email, password);
         
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

}
