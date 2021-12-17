import 'package:bufi_remake/src/api/pantalla_principal_api.dart';
import 'package:bufi_remake/src/models/pantalla_principal_model.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:rxdart/rxdart.dart';

class PantallaPrincipalBloc {
  final pantallaPrincipalApi = PantallaPrincipalApi();
  final _pantallaController = BehaviorSubject<List<PantallaPrincipalModel>>();

  Stream<List<PantallaPrincipalModel>> get pantallaStream => _pantallaController.stream;

  dispose() {
    _pantallaController.close();
  }

  void obtenerPantallaPrincipal() async {
    _pantallaController.sink.add(await pantallaPrincipal());
    await pantallaPrincipalApi.obtenerPantallaPrincipal();
    _pantallaController.sink.add(await pantallaPrincipal());
  }

  Future<List<PantallaPrincipalModel>> pantallaPrincipal() async {
    final List<PantallaPrincipalModel> listFinal = [];
    final pantallasDB = await pantallaPrincipalApi.pantallaPrincipalDatabase.getPantallaPrincipal();
    if (pantallasDB.length > 0) {
      for (var i = 0; i < pantallasDB.length; i++) {
        final List<ProductoModel> listaProductos = [];
        PantallaPrincipalModel pantallaPrincipalModel = PantallaPrincipalModel();

        pantallaPrincipalModel.nombre = pantallasDB[i].nombre;
        pantallaPrincipalModel.tipo = pantallasDB[i].tipo;
        pantallaPrincipalModel.idPantalla = pantallasDB[i].idPantalla;
        final productosPantallaDatabase = await pantallaPrincipalApi.productosPantallaPrincipalDatabase
            .getProductosPantallaPrincipalByIdPantalla(pantallasDB[i].idPantalla.toString());

        if (productosPantallaDatabase.length > 0) {
          for (var y = 0; y < productosPantallaDatabase.length; y++) {
            final productosDB =
                await pantallaPrincipalApi.productoDatabase.getProductosByIdProducto(productosPantallaDatabase[y].idProducto.toString());
            if (productosDB.length > 0) {
              for (var x = 0; x < productosDB.length; x++) {
                ProductoModel productoModel = ProductoModel();
                productoModel.idProducto = productosDB[x].idProducto;
                productoModel.idSubsidiary = productosDB[x].idSubsidiary;
                productoModel.idGood = productosDB[x].idGood;
                productoModel.idItemsubcategory = productosDB[x].idItemsubcategory;
                productoModel.productoName = productosDB[x].productoName;
                productoModel.productoPrice = productosDB[x].productoPrice;
                productoModel.productoCurrency = productosDB[x].productoCurrency;
                productoModel.productoImage = productosDB[x].productoImage;
                productoModel.productoCharacteristics = productosDB[x].productoCharacteristics;
                productoModel.productoBrand = productosDB[x].productoBrand;
                productoModel.productoModel = productosDB[x].productoModel;
                productoModel.productoType = productosDB[x].productoType;
                productoModel.productoSize = productosDB[x].productoSize;
                productoModel.productoMeasure = productosDB[x].productoMeasure;
                productoModel.productoStock = productosDB[x].productoStock;
                productoModel.productoRating = productosDB[x].productoRating;
                productoModel.productoUpdated = productosDB[x].productoUpdated;
                productoModel.productoStatus = productosDB[x].productoStatus;

                listaProductos.add(productoModel);
              }
            }
          }
        }
        pantallaPrincipalModel.productos = listaProductos;

        if (pantallaPrincipalModel.nombre != null) {
          listFinal.add(pantallaPrincipalModel);
        }
      }
    }

    return listFinal;
  }
}
