import 'package:bufi_remake/features/data/models/Explorar/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class SubCategoryLocalDatasource {
  Future<void> insertSubCategory(SubCategoriesModel subCategory);
  Future<List<SubCategoriesModel>> getSubCategories(String idCategory);
}

class SubCategoryLocalDatasourceImpl implements SubCategoryLocalDatasource {
  final dbprovider = DatabaseHelper.instance;

  @override
  Future<void> insertSubCategory(SubCategoriesModel subCategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO SubCategory (idSubCategory,nameSubCategory,idCategory) "
          "VALUES('${subCategory.idSubCategory}', '${subCategory.subCategoryName}', '${subCategory.idCategory}')");
    } catch (e) {
      print("$e Error en la tabla SubCategoria ");
    }
  }

  @override
  Future<List<SubCategoriesModel>> getSubCategories(String idCategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
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
