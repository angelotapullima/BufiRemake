


import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/datasources/productsCategory_local_datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bufibd.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ProductCategoryLocalDataSourceImpl.tableSql);
    //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
  }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
}
