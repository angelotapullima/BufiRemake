import 'dart:convert';
import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:http/http.dart' as http;

abstract class PublicidadRemoteDataSource {
  Future<List<PublicidadEntities>> getPublicidad();
}

class PublicidadRemoteDataSourceImpl implements PublicidadRemoteDataSource {
  final http.Client? client;
  PublicidadRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PublicidadEntities>> getPublicidad() async {
    final List<PublicidadEntities> listPublicidad = [];

    final url = '$API_BASE_URL/api/Inicio/publicidad';
    final response = await client!.post(Uri.parse(url), body: {});
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final decodedData = json.decode(response.body);

    for (var i = 0; i < decodedData.length; i++) {
      PublicidadEntities publi = PublicidadEntities();
      publi.idPublicidad = decodedData[i]["id_publicidad"];
      publi.idCity = decodedData[i]["id_city"];
      publi.idSubsidiary = decodedData[i]["id_subsidiary"];
      publi.publicidadImagen = decodedData[i]["publicidad_img"];
      publi.publicidadOrden = decodedData[i]["publicidad_orden"];
      publi.publicidadEstado = decodedData[i]["publicidad_estado"];
      publi.publicidadDateTime = decodedData[i]["publicidad_datetime"];
      publi.idPago = decodedData[i]["id_pago"];
      listPublicidad.add(publi);
    }

    return listPublicidad;
  }
}
