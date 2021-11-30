import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/screens/features/Explorar/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductItemSubCategoryLocalDataSource {
  Future<void> insertItemSubCategory(ItemSubCategoriesModel itemSubCategory);
  Future<List<ItemSubCategoriesModel>> getItemSubCategories(String idSubCategory);
}

class ProductItemSubCategoryLocalDataSourceImpl implements ProductItemSubCategoryLocalDataSource {

  final dbprovider = DatabaseHelper.instance;


  @override
  Future<void> insertItemSubCategory(ItemSubCategoriesModel itemSubCategory) async {
    try {
      

      final Database db = await dbprovider.getDatabase();
      await db.rawInsert(
          "INSERT OR REPLACE INTO ItemSubCategory (idItemSubCategory,nameItemSubCategory,imagenItemSubCategory,estadoItemSubCategory,idSubCategory) "
          "VALUES('${itemSubCategory.idItemSubCategory}', '${itemSubCategory.nameItemSubCategory}', '${itemSubCategory.imagenItemSubCategory}', '${itemSubCategory.estadoItemSubCategory}', '${itemSubCategory.idSubCategory}')");
    } catch (e) {
      print("$e Error en la tabla ItemSubCategoria ");
    }
  }

  @override
  Future<List<ItemSubCategoriesModel>> getItemSubCategories(String idSubCategory) async {
    try {
      

      final Database db = await dbprovider.getDatabase();
      List<ItemSubCategoriesModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM ItemSubCategory WHERE idSubCategory='$idSubCategory' order by idItemSubCategory");

      if (maps.length > 0) list = ItemSubCategoriesModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
