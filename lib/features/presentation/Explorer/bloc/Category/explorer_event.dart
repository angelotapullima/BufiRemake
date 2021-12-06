part of 'explorer_bloc.dart';

abstract class ExplorerEvent extends Equatable {
  @override
  List<Object> get props => [];

  get idCategory => null;
}

class GetCategoriesBlocEvent extends ExplorerEvent {}

class GetSubCategoriesBlocEvent extends ExplorerEvent {
  final String idCategory;
  final String nombreCategoria;

  GetSubCategoriesBlocEvent(this.idCategory, this.nombreCategoria);
}

class GetItemSubCategoriesBlocEvent extends ExplorerEvent {
  final String idCategory;
  final String nombreSubCategoria;
  final String idSubCategory;

  GetItemSubCategoriesBlocEvent(this.idCategory,this.nombreSubCategoria, this.idSubCategory);
}