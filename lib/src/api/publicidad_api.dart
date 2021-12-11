import 'dart:convert';

import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/database/publicidad_database.dart';
import 'package:bufi_remake/src/models/api_result_model.dart';
import 'package:bufi_remake/src/models/publicidad_model.dart';

import 'package:http/http.dart' as http;

class PublicidadApi {
  final publicidadDatabase = PublicidadDatabase();
  Future<ApiResultModel> obtenerPublicidad() async {
    ApiResultModel result = ApiResultModel();

    try {
      final url = '$API_BASE_URL/api/Inicio/publicidad';

      final response = await http.post(Uri.parse(url), body: {
        'id_ciudad': '1',
      });

      final decodedData = json.decode(response.body);

      if (decodedData.length > 0) {
        result.code = 1;
        for (var i = 0; i < decodedData.length; i++) {
          var data = decodedData[i];
          PublicidadModel publicidad = PublicidadModel();

          publicidad.idPublicidad = data["id_publicidad"];
          publicidad.idCity = data["id_city"];
          publicidad.idSubsidiary = data["id_subsidiary"];
          publicidad.publicidadImagen = data["publicidad_img"];
          publicidad.publicidadOrden = data["publicidad_orden"];
          publicidad.publicidadEstado = data["publicidad_estado"];
          publicidad.publicidadDatetime = data["publicidad_datetime"];
          publicidad.idPago = data["id_pago"];
          await publicidadDatabase.insertPublicidad(publicidad);
        }
      }

      return result;
    } catch (e) {
      result.code = 2;
      return result;
    }
  }
}
