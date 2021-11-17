import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/categoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductCategoryLocalDataSource {
  Future<List<CategoriesModel>> getCategories();

  Future<void> insertCategory(CategoriesModel category);
}

class ProductCategoryLocalDataSourceImpl implements ProductCategoryLocalDataSource {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id TEXT PRIMARY KEY, '
      '$_name TEXT, '
      '$_estado TEXT,'
      '$_img TEXT)';
  static const String _tableName = 'Category';
  static const String _id = 'idCategory';
  static const String _name = 'categoryName';
  static const String _estado = 'categoryEstado';
  static const String _img = 'categoryImage';

  @override
  Future<void> insertCategory(CategoriesModel category) async {
    try {
      final Database db = await getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.idCategory}', '${category.categoryName}', '${category.categoryEstado}', '${category.categoryImage}')");
    } catch (e) {
      print("$e Error en la tabla Categoria ");
    }
  }

  @override
  Future<List<CategoriesModel>> getCategories() async {
    try {
      final Database db = await getDatabase();
      List<CategoriesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Category order by idCategory");

      if (maps.length > 0) list = CategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
