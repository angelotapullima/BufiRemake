import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemSubCategoryDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertItemSubCategories(ItemSubCategoryModel itemsubcategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO ItemSubCategory(idItemSubCategory,nameItemSubCategory,estadoItemSubCategory,imagenItemSubCategory,idSubCategory) "
          "VALUES('${itemsubcategory.idItemSubCategory}','${itemsubcategory.nameItemSubCategory}','${itemsubcategory.estadoItemSubCategory}','${itemsubcategory.imagenItemSubCategory}','${itemsubcategory.idSubCategory}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<ItemSubCategoryModel>> getItemSubCategoriesByIdSubCategory(String idSubCategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ItemSubCategoryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ItemSubCategory WHERE idSubCategory='$idSubCategory' ORDER BY idSubCategory");
      if (maps.length > 0) list = ItemSubCategoryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
