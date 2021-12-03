import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'productosxitemsubcategoria_event.dart';
part 'productosxitemsubcategoria_state.dart';

class ProductosxitemsubcategoriaBloc extends Bloc<ProductosxitemsubcategoriaEvent, ProductosxitemsubcategoriaState> {
  ProductosxitemsubcategoriaBloc() : super(ProductosxitemsubcategoriaInitial()) {
    on<ProductosxitemsubcategoriaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
