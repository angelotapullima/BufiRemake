import 'dart:convert';

import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/database/bienes_database.dart';
import 'package:bufi_remake/src/database/company_database.dart';
import 'package:bufi_remake/src/database/item_sub_category_database.dart';
import 'package:bufi_remake/src/database/productos_database.dart';
import 'package:bufi_remake/src/database/sub_category_database.dart';
import 'package:bufi_remake/src/database/subsidiary_database.dart';
import 'package:bufi_remake/src/models/bienes_model.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:http/http.dart' as http;

class BienesApi {
  final bienesDatabase = BienesDatabase();
  final subcategoryDatabase = SubCategoryDatabase();
  final itemsubcategoryDatabase = ItemSubCategoryDatabase();
  final companyDatabase = CompanyDatabase();
  final productoDatabase = ProductosDatabase();
  final subsidiaryDatabase = SubsidiaryDatabase();

  Future<void> obtenerBienesPorCity() async {
    try {
      final url = '$API_BASE_URL/api/Inicio/listar_bienes_por_id_ciudad';
      final response = await http.post(Uri.parse(url), body: {
        'id_ciudad': '1',
      });

      final decodedData = json.decode(response.body);
      String? idUser = await StorageManager.readData('idUser');

      for (var i = 0; i < decodedData["bienes"]; i++) {
        var data = decodedData["bienes"][i];

        //Almacenamiento de Bienes
        BienesModel bien = BienesModel();
        bien.idGood = data["id_good"];
        bien.goodName = data["good_name"];
        bien.goodSynonyms = data["good_synonyms"];
        await bienesDatabase.insertBienes(bien);

        //Almacenamiento de SubCategory
        SubCategoryModel subcategory = SubCategoryModel();
        subcategory.idCategory = data["id_subcategory"];
        subcategory.nameSubCategory = data["subcategory_name"];
        subcategory.idCategory = data["id_category"];
        await subcategoryDatabase.insertSubCategories(subcategory);

        //Almacenamiento ItemSubCategory
        ItemSubCategoryModel itemsubcategory = ItemSubCategoryModel();
        itemsubcategory.idItemSubCategory = data["id_itemsubcategory"];
        itemsubcategory.nameItemSubCategory = data["itemsubcategory_name"];
        itemsubcategory.estadoItemSubCategory = data["itemsubcategory_estado"];
        itemsubcategory.imagenItemSubCategory = data["itemsubcategory_img"];
        itemsubcategory.idSubCategory = data["id_subcategory"];
        await itemsubcategoryDatabase.insertItemSubCategories(itemsubcategory);

        //Almacenamiento Company
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

        //Almacenamiento Productos
        ProductoModel productoModel = ProductoModel();
        productoModel.idProducto = data["id_subsidiarygood"];
        productoModel.idSubsidiary = data["id_subsidiary"];
        productoModel.idGood = data["id_good"];
        productoModel.idItemsubcategory = data['id_itemsubcategory'];
        productoModel.productoName = data['subsidiary_good_name'];
        productoModel.productoPrice = data['subsidiary_good_price'];
        productoModel.productoCurrency = data['subsidiary_good_currency'];
        productoModel.productoImage = data['subsidiary_good_image'];
        productoModel.productoCharacteristics = data['subsidiary_good_characteristics'];
        productoModel.productoBrand = data['subsidiary_good_brand'];
        productoModel.productoModel = data['subsidiary_good_model'];
        productoModel.productoType = data['subsidiary_good_type'];
        productoModel.productoSize = data['subsidiary_good_size'];
        productoModel.productoStock = data['subsidiary_good_stock'];
        productoModel.productoMeasure = data['subsidiary_good_stock_measure'];
        productoModel.productoRating = data['subsidiary_good_rating'];
        productoModel.productoUpdated = data['subsidiary_good_updated'];
        productoModel.productoStatus = data['subsidiary_good_status'];

        var productList = await productoDatabase.getProductosByIdProducto(data["id_subsidiarygood"]);

        if (productList.length > 0) {
          productoModel.productoFavourite = productList[0].productoFavourite;
        } else {
          productoModel.productoFavourite = '0';
        }
        await productoDatabase.insertProductos(productoModel);

        //Almacenamiento Subsidiary

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
    } catch (e) {
      print(e);
    }
  }
}
