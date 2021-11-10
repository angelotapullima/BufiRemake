part of 'productscategory_bloc.dart';

abstract class ProductscategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductscategoryInitial extends ProductscategoryState {}

class Empty extends ProductscategoryState {}

class Loading extends ProductscategoryState {}

class Loaded extends ProductscategoryState {
  final List<CategoriesEntities> listCategories;

  Loaded({required this.listCategories});

  @override
  List<Object> get props => [listCategories];
}

class Error extends ProductscategoryState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
