import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';

class PublicidadModel extends PublicidadEntities {
  PublicidadModel({
    required String? idPublicidad,
    required String? idCity,
    required String? idSubsidiary,
    required String? publicidadImagen,
    required String? publicidadOrden,
    required String? publicidadDateTime,
    required String? publicidadEstado,
    required String? idPago,
  }) : super(
          idPublicidad: idPublicidad,
          idCity: idCity,
          idSubsidiary: idSubsidiary,
          publicidadImagen: publicidadImagen,
          publicidadOrden: publicidadOrden,
          publicidadDateTime: publicidadDateTime,
          publicidadEstado: publicidadEstado,
          idPago: idPago,
        );

  static List<PublicidadModel> fromJsonList(List<dynamic> json) => json.map((i) => PublicidadModel.fromJson(i)).toList();

  factory PublicidadModel.fromJson(Map<String, dynamic> json) => PublicidadModel(
        idPublicidad: json["idPublicidad"],
        idCity: json["idCity"],
        idSubsidiary: json["idSubsidiary"],
        publicidadImagen: json["publicidadImagen"],
        publicidadOrden: json["publicidadOrden"],
        publicidadDateTime: json["publicidadDateTime"],
        publicidadEstado: json["publicidadEstado"],
        idPago: json["idPago"],
      );
}
