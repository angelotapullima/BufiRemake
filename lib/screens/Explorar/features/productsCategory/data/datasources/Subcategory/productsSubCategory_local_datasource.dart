import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/subCategoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductSubCategoryLocalDatasource {
  Future<void> insertSubCategory(SubCategoriesModel subCategory);
  Future<List<SubCategoriesModel>> getSubCategories(String idCategory);
}

class ProductSubCategoryLocalDatasourceImpl implements ProductSubCategoryLocalDatasource {
  static const String tableSubCategorySql = 'CREATE TABLE $_tableName2('
      '$_id2 TEXT PRIMARY KEY, '
      '$_name2 TEXT, '
      '$_id TEXT)';
  static const String _tableName2 = 'SubCategory';
  static const String _id2 = 'idSubCategory';
  static const String _name2 = 'nameSubCategory';
  static const String _id = 'idCategory';
  @override
  Future<void> insertSubCategory(SubCategoriesModel subCategory) async {
    try {
      final Database db = await getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO SubCategory (idSubCategory,nameSubCategory,idCategory) "
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
      List<Map> maps = await db.rawQuery("SELECT * FROM SubCategory WHERE idCategory ='$idCategory' order by idSubCategory");

      if (maps.length > 0) list = SubCategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
