import 'package:bufi_remake/src/api/bienes_api.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {
  final bienesApi = BienesApi();

  final _productosController = BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosStream => _productosController.stream;

  dispose() {
    _productosController.close();
  }

  void obtenerTodosProductos() async {
    _productosController.sink.add(await bienesApi.productoDatabase.getProductos());
    await bienesApi.obtenerBienesPorCity();
    _productosController.sink.add(await bienesApi.productoDatabase.getProductos());
  }
}
