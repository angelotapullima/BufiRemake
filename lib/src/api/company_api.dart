import 'dart:convert';

import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/database/company_database.dart';
import 'package:bufi_remake/src/database/subsidiary_database.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:http/http.dart' as http;

class CompanyApi {
  final companyDatabase = CompanyDatabase();
  final subsidiaryDatabase = SubsidiaryDatabase();

  Future<int> obtenerCompanies() async {
    try {
      final listCompanies = await companyDatabase.getCompanies();
      double mayor = 0, mayor2 = 0, menor = 0;

      for (var i = 0; i < listCompanies.length; i++) {
        if (double.parse(listCompanies[i].idCompany.toString()) > mayor) {
          mayor = double.parse(listCompanies[i].idCompany.toString());
        }
      }
      mayor2 = mayor;

      for (var x = 0; x < listCompanies.length; x++) {
        if (double.parse(listCompanies[x].idCompany.toString()) < mayor2) {
          menor = double.parse(listCompanies[x].idCompany.toString());
          mayor2 = menor;
        } else {
          menor = mayor2;
        }
      }

      final response = await http.post(Uri.parse("$API_BASE_URL/api/Negocio/listar_negocios"),
          body: {'id_ciudad': '1', 'limite_sup': mayor.toString(), 'limite_inf': menor.toString()});

      final decodedData = json.decode(response.body);
      String? idUser = await StorageManager.readData('idUser');
      for (var y = 0; y < decodedData["results"].length; y++) {
        var data = decodedData["results"][y];
        CompanyModel company = CompanyModel();
        company.idCompany = data["id_company"];
        company.idUser = data["id_user"];
        company.idCity = data["id_city"];
        company.idCategory = data["id_category"];
        company.companyName = data["company_name"];
        company.companyRuc = data["company_ruc"];
        company.companyImage = data["company_image"];
        company.companyType = data["company_type"];
        company.companyShortcode = data["company_shortcode"];
        company.companyDeliveryPropio = data["company_delivery_propio"];
        company.companyDelivery = data["company_delivery"];
        company.companyEntrega = data["company_entrega"];
        company.companyTarjeta = data["company_tarjeta"];
        company.companyVerified = data["company_verified"];
        company.companyRating = data["company_rating"];
        company.companyCreatedAt = data["company_created_at"];
        company.companyJoin = data["company_join"];
        company.companyStatus = data["company_status"];

        if (data["id_user"] == idUser) {
          company.miNegocio = "1";
        } else {
          company.miNegocio = "0";
        }

        await companyDatabase.insertCompany(company);

        //Insertar Subsidiary

        SubsidiaryModel subsidiary = SubsidiaryModel();

        subsidiary.idSubsidiary = data["id_subsidiary"];
        subsidiary.idCompany = data["id_company"];
        subsidiary.subsidiaryName = data["subsidiary_name"];
        subsidiary.subsidiaryDescription = data["subsidiary_description"];
        subsidiary.subsidiaryAddress = data["subsidiary_address"];
        subsidiary.subsidiaryImg = data["subsidiary_img"];
        subsidiary.subsidiaryCellphone = data["subsidiary_cellphone"];
        subsidiary.subsidiaryCellphone2 = data["subsidiary_cellphone_2"];
        subsidiary.subsidiaryEmail = data["subsidiary_email"];
        subsidiary.subsidiaryCoordX = data["subsidiary_coord_x"];
        subsidiary.subsidiaryCoordY = data["subsidiary_coord_y"];
        subsidiary.subsidiaryOpeningHours = data["subsidiary_opening_hours"];
        subsidiary.subsidiaryPrincipal = data["subsidiary_principal"];
        subsidiary.subsidiaryStatus = data["subsidiary_status"];

        final subsi = await subsidiaryDatabase.getSubsidiaryByIdSubsidiary(data["id_subsidiary"]);

        if (subsi.length > 0) {
          subsidiary.subsidiaryFavourite = subsi[0].subsidiaryFavourite;
        } else {
          subsidiary.subsidiaryFavourite = "0";
        }

        await subsidiaryDatabase.insertSubsidiary(subsidiary);
      }

      return 1;
    } catch (e) {
      print(e);
      return 2;
    }
  }
}
