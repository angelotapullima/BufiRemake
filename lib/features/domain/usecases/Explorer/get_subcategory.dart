



import 'package:bufi_remake/features/data/models/Explorer/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/explorer_repository.dart';
import 'package:dartz/dartz.dart';

class GetSubCategory implements UseCase<List<SubCategoriesModel>, SubcategoryParams> {
  final ExplorerRepository? explorerRepository;

  GetSubCategory({this.explorerRepository});

  @override
  Future<Either<Failure, List<SubCategoriesModel>>> call(SubcategoryParams params) async {
    return await explorerRepository!.getSubCategories(params.idCategory);
  }
}

class SubcategoryParams {
  final String? idCategory; 

  SubcategoryParams({required this.idCategory}  );

  List<Object?> get props => [idCategory];
}
