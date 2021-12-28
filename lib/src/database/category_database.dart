import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertCategories(CategoryModel category) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Category(idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.idCategory}','${category.categoryName}','${category.categoryEstado}','${category.categoryImage}')");
    } catch (e) {
      print(e);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CategoryModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Category ORDER BY cast(idCategory as int)");
      if (maps.length > 0) list = CategoryModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
