part of 'productos_bloc.dart';

abstract class ProductosState extends Equatable {
  const ProductosState();
  
  @override
  List<Object> get props => [];
}

class ProductosInitial extends ProductosState {}
