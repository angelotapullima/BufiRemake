import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:sqflite/sqflite.dart';

class SubsidiaryDatabase {
  final dbprovider = DatabaseHelper.instance;
  Future<void> insertSubsidiary(SubsidiaryModel subsidiary) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO Subsidiary(idSubsidiary,idCompany,subsidiaryName,subsidiaryDescription,subsidiaryAddress,subsidiaryImg,"
          "subsidiaryCellphone,subsidiaryCellphone2,subsidiaryEmail,subsidiaryCoordX,subsidiaryCoordY,subsidiaryOpeningHours,subsidiaryPrincipal,"
          "subsidiaryStatus,subsidiaryFavourite) "
          "VALUES('${subsidiary.idSubsidiary}', '${subsidiary.idCompany}', '${subsidiary.subsidiaryName}', '${subsidiary.subsidiaryDescription}', "
          "'${subsidiary.subsidiaryAddress}', '${subsidiary.subsidiaryImg}', '${subsidiary.subsidiaryCellphone}', '${subsidiary.subsidiaryCellphone2}', "
          "'${subsidiary.subsidiaryEmail}', '${subsidiary.subsidiaryCoordX}','${subsidiary.subsidiaryCoordY}', '${subsidiary.subsidiaryOpeningHours}', "
          "'${subsidiary.subsidiaryPrincipal}', '${subsidiary.subsidiaryStatus}', '${subsidiary.subsidiaryFavourite}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<SubsidiaryModel>> getSubsidiaries() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubsidiaryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Subsidiary");
      if (maps.length > 0) list = SubsidiaryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SubsidiaryModel>> getSubsidiaryByIdSubsidiary(String idSubsidiary) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubsidiaryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Subsidiary WHERE idSubsidiary='$idSubsidiary'");
      if (maps.length > 0) list = SubsidiaryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SubsidiaryModel>> getSubsidiaryByIdCompany(String idCompany) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubsidiaryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Subsidiary WHERE idCompany='$idCompany'");
      if (maps.length > 0) list = SubsidiaryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SubsidiaryModel>> getSubsidiaryPrincipalByIdCompany(String idCompany) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubsidiaryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Subsidiary WHERE idCompany='$idCompany' AND subsidiaryPrincipal='1'");
      if (maps.length > 0) list = SubsidiaryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SubsidiaryModel>> getSubsidiaryFavoritos() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubsidiaryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Subsidiary WHERE subsidiaryFavourite ='1' ORDER BY cast(idSubsidiary as int)");
      if (maps.length > 0) list = SubsidiaryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Productos: $e');
      return [];
    }
  }

  Future<void> updatePoint(String idSubsidiary, String point) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawUpdate("UPDATE Subsidiary SET subsidiaryFavourite='$point' "
          "WHERE idSubsidiary='$idSubsidiary'");
    } catch (e) {
      print(e);
    }
  }
}
