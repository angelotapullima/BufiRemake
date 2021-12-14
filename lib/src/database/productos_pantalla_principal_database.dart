import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/pantalla_principal_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductosPantallaPrincipalDatabase {
  final dbprovider = DatabaseHelper.instance;
  Future<void> insertProductosPantalla(ProductosPantallaPrincipalModel producto) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO ProductosPantallaPrincipal (idProducto,idPantalla) "
          "VALUES('${producto.idProducto}','${producto.idPantalla}')");
    } catch (e) {
      print('Error el la base de datos productos pantalla principal al insertar: $e');
    }
  }

  Future<List<ProductosPantallaPrincipalModel>> getProductosPantallaPrincipal() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProductosPantallaPrincipalModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ProductosPantallaPrincipal");
      if (maps.length > 0) list = ProductosPantallaPrincipalModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error el la base de datos productos pantalla principal al listar: $e');
      return [];
    }
  }
}
