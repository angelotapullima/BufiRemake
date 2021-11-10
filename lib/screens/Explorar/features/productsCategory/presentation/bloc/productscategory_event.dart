part of 'productscategory_bloc.dart';

abstract class ProductscategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCategoriesBlocEvent extends ProductscategoryEvent {}
