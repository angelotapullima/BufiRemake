import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ServiciosDatabase {
  final dbprovider = DatabaseHelper.instance;
  Future<void> insertServicios(ServicioModel servicio) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Servicios(idServicio, idSubsidiary, idService, idItemsubcategory,"
          " servicioName, servicioDescription, servicioPrice, servicioCurrency, servicioImage,"
          "servicioRating, servicioUpdated,servicioStatus,servicioFavourite) "
          "VALUES('${servicio.idServicio}', '${servicio.idSubsidiary}','${servicio.idService}',"
          "'${servicio.idItemsubcategory}','${servicio.servicioName}','${servicio.servicioDescription}',"
          "'${servicio.servicioPrice}','${servicio.servicioCurrency}', '${servicio.servicioImage}',"
          "'${servicio.servicioRating}','${servicio.servicioUpdated}', '${servicio.servicioStatus}', '${servicio.servicioFavourite}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<ServicioModel>> getServiciosPorIdServicio(String id) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ServicioModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Servicios WHERE idServicio ='$id'");
      if (maps.length > 0) list = ServicioModel.fromJsonList(maps);
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<ServicioModel>> getServiciosPorIdItemSubCategoria(String id) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ServicioModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Servicios WHERE idItemsubcategory='$id'");
      if (maps.length > 0) list = ServicioModel.fromJsonList(maps);
      return list;
    } catch (e) {
      return [];
    }
  }
}
