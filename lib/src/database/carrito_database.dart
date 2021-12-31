import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/carrito_model.dart';
import 'package:sqflite/sqflite.dart';

class CarritoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertCarrito(CarritoModel carrito) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Carrito(idSubsidiarygood,idSubsidiary,nombre,precio,marca,modelo,talla,"
          "image,moneda,caracteristicas,stock,cantidad,estadoSeleccionado ) "
          "VALUES('${carrito.idSubsidiarygood}','${carrito.idSubsidiary}','${carrito.nombre}','${carrito.precio}',"
          "'${carrito.marca}','${carrito.modelo}','${carrito.talla}','${carrito.image}','${carrito.moneda}',"
          "'${carrito.caracteristicas}','${carrito.stock}','${carrito.cantidad}','${carrito.estadoSeleccionado}')");
    } catch (e) {
      print(e);
    }
  }
}
