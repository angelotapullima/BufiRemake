



import 'package:bufi_remake/features/data/models/Explorer/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/usecase.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/explorer_repository.dart';
import 'package:dartz/dartz.dart';

class GetItemSubCategory implements UseCase<List<ItemSubCategoriesModel>, ItemSubcategoryParams> {
  final ExplorerRepository? explorerRepository;

  GetItemSubCategory({this.explorerRepository});

  @override
  Future<Either<Failure, List<ItemSubCategoriesModel>>> call(ItemSubcategoryParams params) async {
    return await explorerRepository!.getitemSubCategories(params.idSubCategory);
  }
}

class ItemSubcategoryParams {
  final String? idSubCategory; 

  ItemSubcategoryParams({required this.idSubCategory}  );

  List<Object?> get props => [idSubCategory];
}
