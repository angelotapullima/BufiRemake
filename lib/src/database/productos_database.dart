import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductosDatabase {
  final dbprovider = DatabaseHelper.instance;
  Future<void> insertProductos(ProductoModel producto) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Producto(idProducto, idSubsidiary, idGood, idItemsubcategory,"
          " productoName, productoPrice, productoCurrency, productoImage, productoCharacteristics,"
          "productoBrand, productoModel,productoType,productoSize,productoStock,"
          "productoMeasure,productoRating,productoUpdated,productoStatus, productoFavourite) "
          "VALUES('${producto.idProducto}', '${producto.idSubsidiary}','${producto.idGood}',"
          "'${producto.idItemsubcategory}','${producto.productoName}','${producto.productoPrice}',"
          "'${producto.productoCurrency}', '${producto.productoImage}','${producto.productoCharacteristics}',"
          "'${producto.productoBrand}', '${producto.productoModel}','${producto.productoType}',"
          "'${producto.productoSize}', '${producto.productoStock}','${producto.productoMeasure}',"
          " '${producto.productoRating}','${producto.productoUpdated}', '${producto.productoStatus}', '${producto.productoFavourite}')");
    } catch (e) {
      print('Error al insertar en la base de datos Productos: $e');
    }
  }

  Future<List<ProductoModel>> getProductos() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProductoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Producto ORDER BY idProducto");
      if (maps.length > 0) list = ProductoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Productos: $e');
      return [];
    }
  }

  Future<List<ProductoModel>> getProductosByIdProducto(String idProducto) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProductoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Producto WHERE idProducto ='$idProducto' ORDER BY cast(idProducto as int)");
      if (maps.length > 0) list = ProductoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Productos: $e');
      return [];
    }
  }

  Future<List<ProductoModel>> getProductosByIdItemSubCategoria(String idItemSubcategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProductoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Producto WHERE idItemsubcategory ='$idItemSubcategory' ORDER BY cast(idProducto as int)");
      if (maps.length > 0) list = ProductoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Productos: $e');
      return [];
    }
  }
}
