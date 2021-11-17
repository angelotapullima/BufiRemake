part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductscategoryInitial extends CategoriesState {}

class Empty extends CategoriesState {}

class Loading extends CategoriesState {}

class ListaCategorias extends CategoriesState {
  final List<CategoriesEntities> listCategories;

  ListaCategorias({required this.listCategories});

  @override
  List<Object> get props => [listCategories];
}

class ListaSubCategorias extends CategoriesState {
  final List<SubCategoriesModel> listSubCategories;
  final String nombreCategoria;

  ListaSubCategorias({required this.listSubCategories, required this.nombreCategoria});

  @override
  List<Object> get props => [listSubCategories,nombreCategoria];
}

class Error extends CategoriesState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
