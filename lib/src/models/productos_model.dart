class ProductoModel {
  ProductoModel({
    this.idProducto,
    this.idSubsidiary,
    this.idGood,
    this.idItemsubcategory,
    this.productoName,
    this.productoPrice,
    this.productoCurrency,
    this.productoImage,
    this.productoCharacteristics,
    this.productoBrand,
    this.productoModel,
    this.productoType,
    this.productoSize,
    this.productoStock,
    this.productoStockStatus,
    this.productoMeasure,
    this.productoRating,
    this.productoUpdated,
    this.productoStatus,
    this.productoFavourite,
    //this.listFotos,
  });

  String? idProducto;
  String? idSubsidiary;
  String? idGood;
  String? idItemsubcategory;
  String? productoPrice;
  String? productoName;
  String? productoCurrency;
  String? productoImage;
  String? productoCharacteristics;
  String? productoBrand;
  String? productoModel;
  String? productoType;
  String? productoSize;
  String? productoStock;
  String? productoStockStatus;
  String? productoMeasure;
  String? productoRating;
  String? productoUpdated;
  String? productoStatus;
  String? productoFavourite;
  //List<GaleriaProductoModel> listFotos;

  static List<ProductoModel> fromJsonList(List<dynamic> json) => json.map((i) => ProductoModel.fromJson(i)).toList();

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["idProducto"],
        idSubsidiary: json["idSubsidiary"],
        idGood: json["idGood"],
        idItemsubcategory: json["idItemsubcategory"],
        productoName: json["productoName"],
        productoPrice: json["productoPrice"],
        productoCurrency: json["productoCurrency"],
        productoImage: json["productoImage"],
        productoCharacteristics: json["productoCharacteristics"],
        productoBrand: json["productoBrand"],
        productoModel: json["productoModel"],
        productoType: json["productoType"],
        productoSize: json["productoSize"],
        productoStock: json["productoStock"],
        productoStockStatus: json["productoStockStatus"],
        productoMeasure: json["productoMeasure"],
        productoRating: json["productoRating"],
        productoUpdated: json["productoUpdated"],
        productoStatus: json["productoStatus"],
        productoFavourite: json["productoFavourite"],
      );
}
