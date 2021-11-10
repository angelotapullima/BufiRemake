import 'package:bufi_remake/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> loginUser2(String? email, String? password);
}
