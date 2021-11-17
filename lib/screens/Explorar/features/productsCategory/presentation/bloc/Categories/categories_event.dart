part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];

  get idCategory => null;
}

class GetCategoriesBlocEvent extends CategoriesEvent {}

class GetSubCategoriesBlocEvent extends CategoriesEvent {
  final String idCategory;
  final String nombreCategoria;

  GetSubCategoriesBlocEvent(this.idCategory,this.nombreCategoria);
}
