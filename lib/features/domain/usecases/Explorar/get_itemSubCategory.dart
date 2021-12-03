



import 'package:bufi_remake/features/data/models/Explorar/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/domain/repositories/Explorar/explorar_repository.dart';
import 'package:dartz/dartz.dart';

class GetItemSubCategory implements UseCase<List<ItemSubCategoriesModel>, ItemSubcategoryParams> {
  final ExplorarRepository? productCategoryRepository;

  GetItemSubCategory({this.productCategoryRepository});

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