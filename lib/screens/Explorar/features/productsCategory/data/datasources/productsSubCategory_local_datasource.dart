import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/subCategoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductSubCategoryLocalDatasource {
  Future<void> insertSubCategory(SubCategoriesModel subCategory);
  Future<List<SubCategoriesModel>> getSubCategories(String idCategory);
}

class ProductSubCategoryLocalDatasourceImpl implements ProductSubCategoryLocalDatasource {
  static const String tableSubCategorySql = 'CREATE TABLE $_tableName2('
      '$_id2 INTEGER PRIMARY KEY, '
      '$_name2 TEXT, '
      '$_id INTEGER)';
  static const String _tableName2 = 'SubCategory';
  static const String _id2 = 'id_subcategory';
  static const String _name2 = 'subcategory_name';
  static const String _id = 'id_category';
  @override
  Future<void> insertSubCategory(SubCategoriesModel subCategory) async {
    try {
      final Database db = await getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO SubCategory (id_subcategory,subcategory_name,id_category) "
          "VALUES('${subCategory.idSubCategory}', '${subCategory.subCategoryName}', '${subCategory.idCategory}')");
    } catch (e) {
      print("$e Error en la tabla SubCategoria ");
    }
  }

  @override
  Future<List<SubCategoriesModel>> getSubCategories(String idCategory) async {
    try {
      final Database db = await getDatabase();
      List<SubCategoriesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM SubCategory WHERE id_subcategory ='$idCategory' order by id_subcategory");

      if (maps.length > 0) list = SubCategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
