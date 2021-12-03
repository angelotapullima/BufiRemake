



import 'package:bufi_remake/features/data/models/Explorar/Category/categoriesModel.dart';
import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class ExplorarLocalDataSource {
  Future<List<CategoriesModel>> getCategories();

  Future<void> insertCategory(CategoriesModel category);
}

class ProductCategoryLocalDataSourceImpl implements ExplorarLocalDataSource {

  final dbprovider = DatabaseHelper.instance;


  @override
  Future<void> insertCategory(CategoriesModel category) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Category (idCategory,categoryName,categoryEstado,categoryImage) "
          "VALUES('${category.idCategory}', '${category.categoryName}', '${category.categoryEstado}', '${category.categoryImage}')");
    } catch (e) {
      print("$e Error en la tabla Categoria ");
    }
  }

  @override
  Future<List<CategoriesModel>> getCategories() async {
    try {
      
      final Database db = await dbprovider.getDatabase();
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
