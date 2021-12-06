



abstract class ExplorarEvent extends Equatable {
  @override
  List<Object> get props => [];

  get idCategory => null;
}

class GetCategoriesBlocEvent extends ExplorarEvent {}

class GetSubCategoriesBlocEvent extends ExplorarEvent {
  final String idCategory;
  final String nombreCategoria;

  GetSubCategoriesBlocEvent(this.idCategory, this.nombreCategoria);
}

class GetItemSubCategoriesBlocEvent extends ExplorarEvent {
  final String idCategory;
  final String nombreSubCategoria;
  final String idSubCategory;

  GetItemSubCategoriesBlocEvent(this.idCategory,this.nombreSubCategoria, this.idSubCategory);
}
