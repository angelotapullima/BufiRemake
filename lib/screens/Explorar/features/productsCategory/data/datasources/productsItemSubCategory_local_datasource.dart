import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductItemSubCategoryLocalDataSource {
  Future<void> insertItemSubCategory(ItemSubCategoriesModel itemSubCategory);
  Future<List<ItemSubCategoriesModel>> getItemSubCategories(String idSubCategory);
}

class ProductItemSubCategoryLocalDataSourceImpl implements ProductItemSubCategoryLocalDataSource {
  static const String tableiTEMSubCategorySql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_estado TEXT,'
      '$_img TEXT,'
      '$_id1 INTEGER)';
  static const String _tableName = 'ItemSubCategory';
  static const String _id = 'id_itemsubcategory';
  static const String _name = 'itemsubcategory_name';
  static const String _img = 'itemsubcategory_img';
  static const String _estado = 'itemsubcategory_estado';
  static const String _id1 = 'id_subcategory';

  @override
  Future<void> insertItemSubCategory(ItemSubCategoriesModel itemSubCategory) async {
    try {
      final Database db = await getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO ItemSubCategory (id_itemsubcategory,itemsubcategory_name,itemsubcategory_img,itemsubcategory_estado,id_subcategory) "
          "VALUES('${itemSubCategory.idItemSubCategory}', '${itemSubCategory.nameItemSubCategory}', '${itemSubCategory.imagenItemSubCategory}', '${itemSubCategory.estadoItemSubCategory}', '${itemSubCategory.idSubCategory}')");
    } catch (e) {
      print("$e Error en la tabla ItemSubCategoria ");
    }
  }

  @override
  Future<List<ItemSubCategoriesModel>> getItemSubCategories(String idSubCategory) async {
    try {
      final Database db = await getDatabase();
      List<ItemSubCategoriesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ItemSubCategory WHERE id_subcategory='$idSubCategory' order by id_itemsubcategory");

      if (maps.length > 0) list = ItemSubCategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
