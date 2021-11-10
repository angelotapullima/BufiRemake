import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'productscategory_event.dart';
part 'productscategory_state.dart';
class ProductscategoryBloc extends Bloc<ProductscategoryEvent, ProductscategoryState> {
  ProductscategoryBloc() : super(ProductscategoryInitial());
  @override
  Stream<ProductscategoryState> mapEventToState(
    ProductscategoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
