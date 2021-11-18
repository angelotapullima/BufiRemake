import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/Category/productsCategory_local_datasource.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/ItemSubcategory/productsItemSubCategory_local_datasource.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/Subcategory/productsSubCategory_local_datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'bufibd1.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(ProductCategoryLocalDataSourceImpl.tableSql);
      db.execute(ProductItemSubCategoryLocalDataSourceImpl.tableiTEMSubCategorySql);
      db.execute(ProductSubCategoryLocalDatasourceImpl.tableSubCategorySql);
      //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }
}



