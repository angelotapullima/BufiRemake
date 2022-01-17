import 'package:bufi_remake/src/api/bienes_api.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {
  final bienesApi = BienesApi();

  final _productosController = BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosStream => _productosController.stream;

  final _productosItemSubCategoryController = BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosItemSubcategoryStream => _productosItemSubCategoryController.stream;

  final _productosBySubsidiaryController = BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosBySubsidiaryStream => _productosBySubsidiaryController.stream;

  dispose() {
    _productosController.close();
    _productosItemSubCategoryController.close();
    _productosBySubsidiaryController.close();
  }

  void obtenerTodosProductos() async {
    _productosController.sink.add(await bienesApi.productoDatabase.getProductos());
    await bienesApi.obtenerBienesPorCity();
    _productosController.sink.add(await bienesApi.productoDatabase.getProductos());
  }

  void obtenerProductosByItemSubcategory(String idItemSubcategory) async {
    _productosItemSubCategoryController.sink.add(await bienesApi.productoDatabase.getProductosByIdItemSubCategoria(idItemSubcategory));
    await bienesApi.obtenerBienesPorCity();
    _productosItemSubCategoryController.sink.add(await bienesApi.productoDatabase.getProductosByIdItemSubCategoria(idItemSubcategory));
  }

  void obtenerProductosByIdSucursal(String idSucursal) async {
    _productosBySubsidiaryController.sink.add(await bienesApi.productoDatabase.getProductosByIdSubsidiary(idSucursal));
    await bienesApi.listarProductosBySucursal(idSucursal);
    _productosBySubsidiaryController.sink.add(await bienesApi.productoDatabase.getProductosByIdSubsidiary(idSucursal));
  }

  void cleanProductos() {
    _productosItemSubCategoryController.sink.add([]);
  }
}
