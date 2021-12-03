

import 'package:bufi_remake/features/Explorar/Productos/productosXItemSubcategoria/domain/entities/productosEntities.dart';

class ProductoModel extends ProductosEntities{


  ProductoModel({
    required String? idProducto,
    required String? idSubsidiary,
    required String? idGood,
    required String? idItemsubcategory,
    required String? productoName,
    required String? productoPrice,
    required String? productoCurrency,
    required String? productoImage,
    required String? productoCharacteristics,
    required String? productoBrand,
    required String? productoModel,
    required String? productoType,
    required String? productoSize,
    required String? productoStock,
    required String? productoStockStatus,
    required String? productoMeasure,
    required String? productoRating,
    required String? productoUpdated,
    required String? productoStatus,
    required String? productoFavourite,
  
  }) : super(
          idProducto: idProducto,
          idSubsidiary: idSubsidiary,
          idGood: idGood,
          idItemsubcategory: idItemsubcategory,
          productoName: productoName,
          productoPrice: productoPrice,
        );

  
  

  static List<ProductoModel> fromJsonList(List<dynamic> json) => json.map((i) => ProductoModel.fromJson(i)).toList();

  
  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["id_producto"],
        idSubsidiary: json["id_subsidiary"],
        idGood: json["id_good"],
        idItemsubcategory: json["id_itemsubcategory"],
        productoName: json["producto_name"],
        productoPrice: json["producto_price"],
        productoCurrency: json["producto_currency"],
        productoImage: json["producto_image"],
        productoCharacteristics: json["sproducto_characteristics"],
        productoBrand: json["producto_brand"],
        productoModel: json["producto_model"],
        productoType: json["producto_type"],
        productoSize: json["producto_size"],
        productoStock: json["producto_stock"],
        productoStockStatus: json["producto_stock_status"],
        productoMeasure: json["producto_measure"],
        productoRating: json["producto_rating"],
        productoUpdated: json["producto_updated"],
        productoStatus: json["producto_status"],
        productoFavourite: json["producto_favourite"], 
      );

  
}
