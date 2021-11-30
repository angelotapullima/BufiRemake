
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
 class FetchToken implements UseCase<String, TokenParams> {
  final LoginRepository? repository;

  FetchToken({required this.repository});

  @override
  Future<Either<Failure, String>> call(TokenParams params) async {
    return await repository!.fetchCachedToken();
  }
}

class TokenParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}