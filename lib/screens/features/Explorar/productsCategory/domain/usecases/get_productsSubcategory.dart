



import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/screens/features/Explorar/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/screens/features/Explorar/productsCategory/domain/repositories/productsCategory_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsSubCategory implements UseCase<List<SubCategoriesModel>, SubcategoryParams> {
  final ProductCategoryRepository? productCategoryRepository;

  GetProductsSubCategory({this.productCategoryRepository});

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
