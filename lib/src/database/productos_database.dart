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

  Future<void> upDateProductos(ProductoModel producto) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawUpdate("UPDATE Producto SET idSubsidiary= '${producto.idSubsidiary}',"
          "idGood='${producto.idGood}',"
          "idItemsubcategory='${producto.idItemsubcategory}',"
          "productoName='${producto.productoName}',"
          "productoPrice='${producto.productoPrice}',"
          "productoCurrency='${producto.productoCurrency}',"
          "productoImage='${producto.productoImage}',"
          "productoCharacteristics='${producto.productoCharacteristics}',"
          "productoBrand='${producto.productoBrand}',"
          "productoModel='${producto.productoModel}',"
          "productoType= '${producto.productoType}',"
          "productoSize='${producto.productoSize}',"
          "productoStock='${producto.productoStock}',"
          "productoMeasure='${producto.productoMeasure}',"
          "productoRating='${producto.productoRating}',"
          "productoUpdated= '${producto.productoUpdated}',"
          "productoStatus='${producto.productoStatus}',"
          "productoFavourite= '${producto.productoFavourite}' "
          "WHERE idProducto='${producto.idProducto}'");
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePoint(String idProducto, String point) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawUpdate("UPDATE Producto SET productoFavourite='$point' "
          "WHERE idProducto='$idProducto'");
    } catch (e) {
      print(e);
    }
  }
}
