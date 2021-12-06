



import 'package:bufi_remake/features/domain/entities/Explorer/categoriesEntities.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/explorar_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCategory implements UseCase<List<CategoriesEntities>, TokenParams> {
  final ExplorarRepository? productCategoryRepository;

  GetCategory({this.productCategoryRepository});

  @override
  Future<Either<Failure, List<CategoriesEntities>>> call(TokenParams params) async {
    return await productCategoryRepository!.getCategories();
  }
}

class TokenParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
