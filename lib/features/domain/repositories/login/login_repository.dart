import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/entities/login/login.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> loginUser2(String? email, String? password);
  Future<Either<Failure, String>> fetchCachedToken();
}
