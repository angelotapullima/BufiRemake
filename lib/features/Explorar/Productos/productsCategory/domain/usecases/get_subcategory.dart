



import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/repositories/explorar_repository.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetSubCategory implements UseCase<List<SubCategoriesModel>, SubcategoryParams> {
  final ExplorarRepository? productCategoryRepository;

  GetSubCategory({this.productCategoryRepository});

  @override
  Future<Either<Failure, List<SubCategoriesModel>>> call(SubcategoryParams params) async {
    return await productCategoryRepository!.getSubCategories(params.idCategory);
  }
}

class SubcategoryParams {
  final String? idCategory; 

  SubcategoryParams({required this.idCategory}  );

  List<Object?> get props => [idCategory];
}
