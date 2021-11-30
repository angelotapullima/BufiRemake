



import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/screens/features/Explorar/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:bufi_remake/screens/features/Explorar/productsCategory/domain/repositories/productsCategory_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsItemSubCategory implements UseCase<List<ItemSubCategoriesModel>, ItemSubcategoryParams> {
  final ProductCategoryRepository? productCategoryRepository;

  GetProductsItemSubCategory({this.productCategoryRepository});

  @override
  Future<Either<Failure, List<ItemSubCategoriesModel>>> call(ItemSubcategoryParams params) async {
    return await productCategoryRepository!.getitemSubCategories(params.idSubCategory);
  }
}

class ItemSubcategoryParams {
  final String? idSubCategory; 

  ItemSubcategoryParams({required this.idSubCategory}  );

  List<Object?> get props => [idSubCategory];
}
