import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/categoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductCategoryLocalDataSource {
  Future<List<CategoriesModel>> getCategories();

  Future<void> insertCategory(CategoriesModel category);
}

class ProductCategoryLocalDataSourceImpl implements ProductCategoryLocalDataSource {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_estado TEXT,'
      '$_img TEXT,';
  static const String _tableName = 'Category';
  static const String _id = 'id_category';
  static const String _name = 'category_name';
  static const String _estado = 'category_estado';
  static const String _img = 'category_img';

  @override
  Future<void> insertCategory(CategoriesModel category) async {
    try {
      final Database db = await getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Category (id_category,category_name,category_estado,category_img) "
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
      List<Map> maps = await db.rawQuery("SELECT * FROM Category order by id_category");

      if (maps.length > 0) list = CategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datossss");
      return [];
    }
  }
}
