import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/publicidad_model.dart';
import 'package:sqflite/sqflite.dart';

class PublicidadDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertPublicidad(PublicidadModel publicidad) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO Publicidad (idPublicidad,idCity,idSubsidiary,publicidadImagen,publicidadOrden,publicidadDateTime,publicidadEstado,idPago) "
          "VALUES('${publicidad.idPublicidad}', '${publicidad.idCity}', '${publicidad.idSubsidiary}', '${publicidad.publicidadImagen}', '${publicidad.publicidadOrden}', '${publicidad.publicidadDatetime}', '${publicidad.publicidadEstado}', '${publicidad.idPago}')");
    } catch (e) {
      print("$e Error en la tabla Publicidad");
    }
  }

  Future<List<PublicidadModel>> getPublicidad() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<PublicidadModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Publicidad order by idPublicidad");

      if (maps.length > 0) list = PublicidadModel.fromJsonList(maps);
      print(list.length);
      return list;
    } catch (e) {
      print("$e Error en la base de datos");
      return [];
    }
  }
}
