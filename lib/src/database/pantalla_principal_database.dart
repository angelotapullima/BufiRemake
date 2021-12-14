import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/pantalla_principal_model.dart';
import 'package:sqflite/sqflite.dart';

class PantallaPrincipalDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertPantalla(PantallaPrincipalModel pantalla) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO PantallaPrincipal(idPantalla,nombre,tipo)"
          "VALUES('${pantalla.idPantalla}','${pantalla.nombre}','${pantalla.tipo}')");
    } catch (e) {
      print("$e Error en la tabla PantallaPrincipal");
    }
  }

  Future<List<PantallaPrincipalModel>> getPantallaPrincipal() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<PantallaPrincipalModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM PantallaPrincipal");

      if (maps.length > 0) list = PantallaPrincipalModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print("$e Error en la tabla PantallaPrincipal");
      return [];
    }
  }
}
