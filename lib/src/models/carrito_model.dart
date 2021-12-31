class CarritoModel {
  String? idSubsidiarygood;
  String? idSubsidiary;
  String? nombre;
  String? precio;
  String? marca;
  String? modelo;
  String? talla;
  String? image;
  String? moneda;
  String? caracteristicas;
  String? stock;
  String? cantidad;
  String? estadoSeleccionado;

  CarritoModel({
    this.idSubsidiarygood,
    this.idSubsidiary,
    this.nombre,
    this.precio,
    this.marca,
    this.modelo,
    this.talla,
    this.image,
    this.moneda,
    this.caracteristicas,
    this.stock,
    this.cantidad,
    this.estadoSeleccionado,
  });

  static List<CarritoModel> fronJsonList(List<dynamic> json) => json.map((i) => CarritoModel.fromJson(i)).toList();

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idSubsidiarygood: json["idSubsidiarygood"],
        idSubsidiary: json["idSubsidiary"],
        nombre: json["nombre"],
        precio: json["precio"],
        marca: json["marca"],
        modelo: json["modelo"],
        talla: json["talla"],
        image: json["image"],
        moneda: json["moneda"],
        caracteristicas: json["caracteristicas"],
        stock: json["stock"],
        cantidad: json["cantidad"],
        estadoSeleccionado: json["estadoSeleccionado"],
      );
}
