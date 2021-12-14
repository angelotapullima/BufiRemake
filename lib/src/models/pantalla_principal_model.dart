import 'package:bufi_remake/src/models/productos_model.dart';

class PantallaPrincipalModel {
  String? nombre;
  String? tipo;
  String? idPantalla;
  List<ProductoModel>? productos;

  PantallaPrincipalModel({this.idPantalla, this.nombre, this.tipo, this.productos});

  static List<PantallaPrincipalModel> fromJsonList(List<dynamic> json) => json.map((i) => PantallaPrincipalModel.fromJson(i)).toList();

  factory PantallaPrincipalModel.fromJson(Map<String, dynamic> json) => PantallaPrincipalModel(
        idPantalla: json["idPantalla"],
        tipo: json["tipo"],
        nombre: json["nombre"],
      );
}

class ProductosPantallaPrincipalModel {
  String? idProducto;
  String? idPantalla;

  ProductosPantallaPrincipalModel({this.idProducto, this.idPantalla});

  static List<ProductosPantallaPrincipalModel> fromJsonList(List<dynamic> json) =>
      json.map((i) => ProductosPantallaPrincipalModel.fromJson(i)).toList();

  factory ProductosPantallaPrincipalModel.fromJson(Map<String, dynamic> json) => ProductosPantallaPrincipalModel(
        idPantalla: json["idPantalla"],
        idProducto: json["idProducto"],
      );
}
