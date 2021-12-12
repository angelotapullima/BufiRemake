class PublicidadModel {
  String? idPublicidad;
  String? idCity;
  String? idSubsidiary;
  String? publicidadImagen;
  String? publicidadOrden;
  String? publicidadEstado;
  String? publicidadDatetime;
  String? idPago;

  PublicidadModel(
      {this.idPublicidad,
      this.idCity,
      this.idSubsidiary,
      this.publicidadImagen,
      this.publicidadOrden,
      this.publicidadEstado,
      this.publicidadDatetime,
      this.idPago});
  static List<PublicidadModel> fromJsonList(List<dynamic> json) => json.map((i) => PublicidadModel.fromJson(i)).toList();

  factory PublicidadModel.fromJson(Map<String, dynamic> json) => PublicidadModel(
        idPublicidad: json["idPublicidad"],
        idCity: json["idCity"],
        idSubsidiary: json["idSubsidiary"],
        publicidadImagen: json["publicidadImagen"],
        publicidadOrden: json["publicidadOrden"],
        publicidadEstado: json["publicidadEstado"],
        publicidadDatetime: json["publicidadDateTime"],
        idPago: json["idPago"],
      );
}
