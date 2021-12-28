import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:sqflite/sqflite.dart';

class SubCategoryDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertSubCategories(SubCategoryModel subcategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO SubCategory(idSubCategory,nameSubCategory,idCategory) "
          "VALUES('${subcategory.idSubCategory}','${subcategory.nameSubCategory}','${subcategory.idCategory}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<SubCategoryModel>> getSubCategoriesByIdCategory(String idCategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SubCategoryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM SubCategory WHERE idCategory='$idCategory' ORDER BY idSubCategory");
      if (maps.length > 0) list = SubCategoryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
