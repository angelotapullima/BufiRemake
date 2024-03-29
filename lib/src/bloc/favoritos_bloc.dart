import 'package:bufi_remake/src/database/productos_database.dart';
import 'package:bufi_remake/src/database/servicios_database.dart';
import 'package:bufi_remake/src/database/subsidiary_database.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosBloc {
  final productoDatabase = ProductosDatabase();
  final serviciosDatabase = ServiciosDatabase();
  final subsidiaryDatabase = SubsidiaryDatabase();

  final _productsFavoriteController = BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosFavoriteStream => _productsFavoriteController.stream;

  final _subsidiaryFavoriteController = BehaviorSubject<List<SubsidiaryModel>>();
  Stream<List<SubsidiaryModel>> get subsidiariesFavoriteStream => _subsidiaryFavoriteController.stream;

  final _serviciosFavoriteController = BehaviorSubject<List<ServicioModel>>();
  Stream<List<ServicioModel>> get serviciosFavoriteStream => _serviciosFavoriteController.stream;

  dispose() {
    _productsFavoriteController.close();
    _subsidiaryFavoriteController.close();
    _serviciosFavoriteController.close();
  }

  void obtenerProductosFavoritos() async {
    _productsFavoriteController.sink.add(await productoDatabase.getProductosFavoritos());
  }

  void obtenerSubsidiaryFavorites() async {
    _subsidiaryFavoriteController.sink.add(await subsidiaryDatabase.getSubsidiaryFavoritos());
  }

  void obtenerServiciosFavorites() async {
    _serviciosFavoriteController.sink.add(await serviciosDatabase.getServiciosFavoritos());
  }

  void update() async {
    _productsFavoriteController.sink.add(await productoDatabase.getProductosFavoritos());
    _subsidiaryFavoriteController.sink.add(await subsidiaryDatabase.getSubsidiaryFavoritos());
    _serviciosFavoriteController.sink.add(await serviciosDatabase.getServiciosFavoritos());
  }
}
