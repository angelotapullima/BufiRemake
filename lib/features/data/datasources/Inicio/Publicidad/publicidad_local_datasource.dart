import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/features/data/models/Inicio/Publicidad/publicidad_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class PublicidadLocalDataSource {
  Future<List<PublicidadModel>> getPublicidad();

  Future<void> insertPublicidad(PublicidadModel publicidad);
}

class PublicidadLocalDataSourceImpl implements PublicidadLocalDataSource {
  final dbprovider = DatabaseHelper.instance;

  @override
  Future<void> insertPublicidad(PublicidadModel publicidad) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO Publicidad (idPublicidad,idCity,idSubsidiary,publicidadImagen,publicidadOrden,publicidadDateTime,publicidadEstado,idPago) "
          "VALUES('${publicidad.idPublicidad}', '${publicidad.idCity}', '${publicidad.idSubsidiary}', '${publicidad.publicidadImagen}', '${publicidad.publicidadOrden}', '${publicidad.publicidadDateTime}', '${publicidad.publicidadEstado}', '${publicidad.idPago}')");
    } catch (e) {
      print("$e Error en la tabla Publicidad");
    }
  }

  @override
  Future<List<PublicidadModel>> getPublicidad() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<PublicidadModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Publicidad order by idPublicidad");

      if (maps.length > 0) list = PublicidadModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print("$e Error en la base de datos");
      return [];
    }
  }
}
