import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/bienes_model.dart';
import 'package:sqflite/sqflite.dart';

class BienesDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertBienes(BienesModel bien) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Bienes(idGood,goodName,goodSynonyms) "
          "VALUES('${bien.idGood}','${bien.goodName}','${bien.goodSynonyms}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<BienesModel>> getBienes() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<BienesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Bienes ORDER BY cast(idGood as int)");
      if (maps.length > 0) list = BienesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
