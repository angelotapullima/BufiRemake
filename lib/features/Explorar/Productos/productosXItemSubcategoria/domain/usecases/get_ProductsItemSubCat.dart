

/* 

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



 */