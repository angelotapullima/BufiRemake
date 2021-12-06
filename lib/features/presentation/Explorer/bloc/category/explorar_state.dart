part of 'explorar_bloc.dart';

abstract class ExplorarState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductscategoryInitial extends ExplorarState {}

class Empty extends ExplorarState {}

class Loading extends ExplorarState {}

class ListaCategorias extends ExplorarState {
  final List<CategoriesEntities> listCategories;

  ListaCategorias({required this.listCategories});

  @override
  List<Object> get props => [listCategories];
}

class ListaSubCategorias extends ExplorarState {
  final List<SubCategoriesModel> listSubCategories;
  final String nombreCategoria;

  ListaSubCategorias({required this.listSubCategories, required this.nombreCategoria});

  @override
  List<Object> get props => [listSubCategories,nombreCategoria];
}

class ListaItemSubCategorias extends ExplorarState {
  final String idCategory;

  final List<ItemSubCategoriesModel> listItemSubCategories;
  final String nombreSubCategoria;
  ListaItemSubCategorias({required this.idCategory, required this.listItemSubCategories, required this.nombreSubCategoria});

  @override
  List<Object> get props => [idCategory,listItemSubCategories,nombreSubCategoria];
}

class Error extends ExplorarState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
