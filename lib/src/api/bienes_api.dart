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

      for (var i = 0; i < decodedData["bienes"].length; i++) {
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

  Future<Null> listarProductosBySucursal(String idSucursal) async {
    try {
      final productosPorSucursal = await productoDatabase.getProductosByIdSubsidiary(idSucursal);

      double mayor = 0;
      double mayor2 = 0;
      double menor = 0;
      if (productosPorSucursal.length > 0) {
        for (var i = 0; i < productosPorSucursal.length; i++) {
          if (double.parse(productosPorSucursal[i].idProducto.toString()) > mayor) {
            mayor = double.parse(productosPorSucursal[i].idProducto.toString());
          }
        }
      }
      mayor2 = mayor;

      if (productosPorSucursal.length > 0) {
        for (var x = 0; x < productosPorSucursal.length; x++) {
          if (double.parse(productosPorSucursal[x].idProducto.toString()) < mayor2) {
            menor = double.parse(productosPorSucursal[x].idProducto.toString());
            mayor2 = menor;
          } else {
            menor = mayor2;
          }
        }
      }

      final response = await http.post(Uri.parse('$API_BASE_URL/api/Negocio/listar_productos_por_sucursal'), body: {
        'id_sucursal': idSucursal,
        'limite_sup': mayor.toString(),
        'limite_inf': menor.toString(),
        'id_ciudad': '1',
      });

      final decodedData = json.decode(response.body);

      if (decodedData['results'].length > 0) {
        for (var i = 0; i < decodedData['results'].length; i++) {
          //SubsidiaryGoodModel
          ProductoModel productoModel = ProductoModel();
          productoModel.idProducto = decodedData['results'][i]["id_subsidiarygood"];
          productoModel.idSubsidiary = decodedData['results'][i]["id_subsidiary"];
          productoModel.idGood = decodedData['results'][i]["id_good"];
          productoModel.idItemsubcategory = decodedData['results'][i]['id_itemsubcategory'];
          productoModel.productoName = decodedData['results'][i]['subsidiary_good_name'];
          productoModel.productoPrice = decodedData['results'][i]['subsidiary_good_price'];
          productoModel.productoCurrency = decodedData['results'][i]['subsidiary_good_currency'];
          productoModel.productoImage = decodedData['results'][i]['subsidiary_good_image'];
          productoModel.productoCharacteristics = decodedData['results'][i]['subsidiary_good_characteristics'];
          productoModel.productoBrand = decodedData['results'][i]['subsidiary_good_brand'];
          productoModel.productoModel = decodedData['results'][i]['subsidiary_good_model'];
          productoModel.productoType = decodedData['results'][i]['subsidiary_good_type'];
          productoModel.productoSize = decodedData['results'][i]['subsidiary_good_size'];
          productoModel.productoStock = decodedData['results'][i]['subsidiary_good_stock'];
          productoModel.productoMeasure = decodedData['results'][i]['subsidiary_good_stock_measure'];
          productoModel.productoRating = decodedData['results'][i]['subsidiary_good_rating'];
          productoModel.productoUpdated = decodedData['results'][i]['subsidiary_good_updated'];
          productoModel.productoStatus = decodedData['results'][i]['subsidiary_good_status'];

          var productList = await productoDatabase.getProductosByIdGood(decodedData['results'][i]['id_subsidiarygood']);

          if (productList.length > 0) {
            productoModel.productoFavourite = productList[0].productoFavourite;
          } else {
            productoModel.productoFavourite = '0';
          }
          await productoDatabase.insertProductos(productoModel);

          SubsidiaryModel submodel = SubsidiaryModel();
          submodel.idCompany = decodedData['results'][i]["id_company"];
          submodel.idSubsidiary = decodedData['results'][i]["id_subsidiary"];
          submodel.subsidiaryName = decodedData['results'][i]['subsidiary_name'];
          submodel.subsidiaryAddress = decodedData['results'][i]['subsidiary_address'];
          submodel.subsidiaryCellphone = decodedData['results'][i]['subsidiary_cellphone'];
          submodel.subsidiaryCellphone2 = decodedData['results'][i]['subsidiary_cellphone_2'];
          submodel.subsidiaryEmail = decodedData['results'][i]['subsidiary_email'];
          submodel.subsidiaryCoordX = decodedData['results'][i]['subsidiary_coord_x'];
          submodel.subsidiaryCoordY = decodedData['results'][i]['subsidiary_coord_y'];
          submodel.subsidiaryOpeningHours = decodedData['results'][i]['subsidiary_opening_hours'];
          submodel.subsidiaryPrincipal = decodedData['results'][i]['subsidiary_principal'];
          submodel.subsidiaryStatus = decodedData['results'][i]['subsidiary_status'];
          submodel.subsidiaryImg = decodedData['results'][i]['subsidiary_img'];

          final list = await subsidiaryDatabase.getSubsidiaryByIdSubsidiary(decodedData['results'][i]["id_subsidiary"]);

          if (list.length > 0) {
            submodel.subsidiaryFavourite = list[0].subsidiaryFavourite;
            //Subsidiary
          } else {
            submodel.subsidiaryFavourite = "0";
          }

          await subsidiaryDatabase.insertSubsidiary(submodel);

          //BienesModel
          BienesModel goodmodel = BienesModel();
          goodmodel.idGood = decodedData['results'][i]['id_good'];
          goodmodel.goodName = decodedData['results'][i]['good_name'];
          goodmodel.goodSynonyms = decodedData['results'][i]['good_synonyms'];
          await bienesDatabase.insertBienes(goodmodel);

          //ItemSubCategoriaModel
          ItemSubCategoryModel itemSubCategoriaModel = ItemSubCategoryModel();
          itemSubCategoriaModel.idSubCategory = decodedData['results'][i]['id_subcategory'];
          itemSubCategoriaModel.idItemSubCategory = decodedData['results'][i]['itemsubcategory_name'];
          itemSubCategoriaModel.nameItemSubCategory = decodedData['results'][i]['itemsubcategory_name'];
          itemSubCategoriaModel.imagenItemSubCategory = decodedData['results'][i]['itemsubcategory_img'];
          await itemsubcategoryDatabase.insertItemSubCategories(itemSubCategoriaModel);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
