import 'dart:convert';

import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/database/company_database.dart';
import 'package:bufi_remake/src/database/pantalla_principal_database.dart';
import 'package:bufi_remake/src/database/productos_database.dart';
import 'package:bufi_remake/src/database/productos_pantalla_principal_database.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:bufi_remake/src/models/pantalla_principal_model.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:http/http.dart' as http;

class PantallaPrincipalApi {
  final pantallaPrincipalDatabase = PantallaPrincipalDatabase();
  final productosPantallaPrincipalDatabase = ProductosPantallaPrincipalDatabase();
  final companyDatabase = CompanyDatabase();
  final productoDatabase = ProductosDatabase();

  Future<int> obtenerPantallaPrincipal() async {
    try {
      final url = '$API_BASE_URL/api/Inicio/pantalla_principal';

      final response = await http.post(Uri.parse(url), body: {
        'id_ciudad': '1',
        'app': 'true',
      });

      final decodedData = json.decode(response.body);
      if (decodedData["secciones"].length > 0) {
        String? idUser = await StorageManager.readData('idUser');
        for (var i = 0; i < decodedData["secciones"].length; i++) {
          var dataSecciones = decodedData["secciones"][i];
          PantallaPrincipalModel pantallaPrincipalModel = PantallaPrincipalModel();

          pantallaPrincipalModel.nombre = dataSecciones['titulo'].toString();
          pantallaPrincipalModel.tipo = dataSecciones['tipo'].toString();
          pantallaPrincipalModel.idPantalla = dataSecciones['id'].toString();
          await pantallaPrincipalDatabase.insertPantalla(pantallaPrincipalModel);

          for (var x = 0; x < dataSecciones['productos'].length; i++) {
            var dataProductos = dataSecciones['productos'][x];

            ProductoModel productoModel = ProductoModel();
            productoModel.idProducto = dataProductos["id_subsidiarygood"];
            productoModel.idSubsidiary = dataProductos["id_subsidiary"];
            productoModel.idGood = dataProductos["id_good"];
            productoModel.idItemsubcategory = dataProductos['id_itemsubcategory'];
            productoModel.productoName = dataProductos['subsidiary_good_name'];
            productoModel.productoPrice = dataProductos['subsidiary_good_price'];
            productoModel.productoCurrency = dataProductos['subsidiary_good_currency'];
            productoModel.productoImage = dataProductos['subsidiary_good_image'];
            productoModel.productoCharacteristics = dataProductos['subsidiary_good_characteristics'];
            productoModel.productoBrand = dataProductos['subsidiary_good_brand'];
            productoModel.productoModel = dataProductos['subsidiary_good_model'];
            productoModel.productoType = dataProductos['subsidiary_good_type'];
            productoModel.productoSize = dataProductos['subsidiary_good_size'];
            productoModel.productoStock = dataProductos['subsidiary_good_stock'];
            productoModel.productoMeasure = dataProductos['subsidiary_good_stock_measure'];
            productoModel.productoRating = dataProductos['subsidiary_good_rating'];
            productoModel.productoUpdated = dataProductos['subsidiary_good_updated'];
            productoModel.productoStatus = dataProductos['subsidiary_good_status'];

            var productList = await productoDatabase.getProductosByIdProducto(dataProductos["id_subsidiarygood"]);

            if (productList.length > 0) {
              productoModel.productoFavourite = productList[0].productoFavourite;
            } else {
              productoModel.productoFavourite = '0';
            }
            await productoDatabase.insertProductos(productoModel);

            //INSERTAR COMPANIES

            CompanyModel companyModel = CompanyModel();

            companyModel.idCompany = dataProductos['id_company'];
            companyModel.idUser = dataProductos['id_user'];
            companyModel.idCity = dataProductos['id_city'];
            companyModel.idCategory = dataProductos['id_category'];
            companyModel.companyName = dataProductos['company_name'];
            companyModel.companyRuc = dataProductos['company_ruc'];
            companyModel.companyImage = dataProductos['company_image'];
            companyModel.companyType = dataProductos['company_type'];
            companyModel.companyShortcode = dataProductos['company_shortcode'];
            companyModel.companyDeliveryPropio = dataProductos['company_delivery_propio'];
            companyModel.companyDelivery = dataProductos['company_delivery'];
            companyModel.companyEntrega = dataProductos['company_entrega'];
            companyModel.companyTarjeta = dataProductos['company_tarjeta'];
            companyModel.companyVerified = dataProductos['company_verified'];
            companyModel.companyRating = dataProductos['company_rating'];
            companyModel.companyCreatedAt = dataProductos['company_created_at'];
            companyModel.companyJoin = dataProductos['company_join'];
            companyModel.companyStatus = dataProductos['company_status'];

            if (companyModel.idUser == idUser) {
              companyModel.miNegocio = '1';
            } else {
              companyModel.miNegocio = '0';
            }

            await companyDatabase.insertCompany(companyModel);

            ProductosPantallaPrincipalModel productosPantallaModel = ProductosPantallaPrincipalModel();
            productosPantallaModel.idProducto = dataProductos['id_subsidiarygood'];
            productosPantallaModel.idPantalla = pantallaPrincipalModel.idPantalla;
            await productosPantallaPrincipalDatabase.insertProductosPantalla(productosPantallaModel);
          }
        }
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print(e);
      return 2;
    }
  }
}
