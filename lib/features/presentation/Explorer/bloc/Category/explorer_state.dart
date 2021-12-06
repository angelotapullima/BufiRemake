part of 'explorer_bloc.dart';







abstract class ExplorerState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExplorerInitial extends ExplorerState {}

class Empty extends ExplorerState {}

class Loading extends ExplorerState {}

class ListaCategorias extends ExplorerState {
  final List<CategoriesEntities> listCategories;

  ListaCategorias({required this.listCategories});

  @override
  List<Object> get props => [listCategories];
}

class ListaSubCategorias extends ExplorerState {
  final List<SubCategoriesModel> listSubCategories;
  final String nombreCategoria;

  ListaSubCategorias({required this.listSubCategories, required this.nombreCategoria});

  @override
  List<Object> get props => [listSubCategories,nombreCategoria];
}

class ListaItemSubCategorias extends ExplorerState {
  final String idCategory;

  final List<ItemSubCategoriesModel> listItemSubCategories;
  final String nombreSubCategoria;
  ListaItemSubCategorias({required this.idCategory, required this.listItemSubCategories, required this.nombreSubCategoria});

  @override
  List<Object> get props => [idCategory,listItemSubCategories,nombreSubCategoria];
}

class Error extends ExplorerState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}