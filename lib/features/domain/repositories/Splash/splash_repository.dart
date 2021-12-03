



import 'package:bufi_remake/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  
  Future<Either<Failure, String>> fetchCachedToken();
}
