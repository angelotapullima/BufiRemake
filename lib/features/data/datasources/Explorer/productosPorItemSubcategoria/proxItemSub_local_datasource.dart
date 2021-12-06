/* import 'package:bufi_remake/features/data/models/Explorer/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProXItemSubLocalDataSource {
  Future<List<ProductoModel>> getProductosPorItemSubcategoria(String idItemSubCategory);

  Future<void> insertProducts(ProductoModel producto);
}

class ProXItemSubLocalDataSourceImpl implements ProXItemSubLocalDataSource {
  final dbprovider = DatabaseHelper.instance;

  @override
  Future<void> insertProducts(ProductoModel producto) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.rawInsert("INSERT OR REPLACE INTO Producto (id_producto, id_subsidiary, id_good, id_itemsubcategory,"
          " producto_name, producto_price, producto_currency, producto_image, producto_characteristics,"
          "producto_brand, producto_model,producto_type,producto_size,producto_stock,"
          "producto_measure,producto_rating,producto_updated,producto_status, producto_favourite) "
          "VALUES('${producto.idProducto}', '${producto.idSubsidiary}','${producto.idGood}',"
          "'${producto.idItemsubcategory}','${producto.productoName}','${producto.productoPrice}',"
          "'${producto.productoCurrency}', '${producto.productoImage}','${producto.productoCharacteristics}',"
          "'${producto.productoBrand}', '${producto.productoModel}','${producto.productoType}',"
          "'${producto.productoSize}', '${producto.productoStock}','${producto.productoMeasure}',"
          " '${producto.productoRating}','${producto.productoUpdated}', '${producto.productoStatus}', '${producto.productoFavourite}')");
    } catch (e) {
      print("$e Error en la tabla Categoria ");
    }
  }

  @override
  Future<List<ProductoModel>> getProductosPorItemSubcategoria(String idItemSubCategory) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ProductoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Producto WHERE id_itemsubcategory='$idItemSubCategory' order by id_producto");

      if (maps.length > 0) list = ProductoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la base de datos");
      return [];
    }
  }
}
 */