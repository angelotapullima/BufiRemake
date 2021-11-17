import 'dart:convert';

import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/dataGeneralEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/subCategoriesEntities.dart';
import 'package:http/http.dart' as http;

abstract class ProductsCategoryRemoteDataSource {
  Future<DataGeneralEntities> getCategories();
}

class ProductsCategoryRemoteDataSourceImpl implements ProductsCategoryRemoteDataSource {
  final http.Client? client;

  ProductsCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<DataGeneralEntities> getCategories() async {
    final List<CategoriesEntities> categories = [];
    final List<SubCategoriesEntities> subCategories = [];
    final List<ItemSubCateriesEntities> itemSubCategories = [];
    final url = '$API_BASE_URL/api/Inicio/listar_categorias';

    final response = await client!.post(Uri.parse(url), body: {});
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final decodedData = json.decode(response.body);

    for (var i = 0; i < decodedData.length; i++) {
      CategoriesEntities categ = CategoriesEntities();
      categ.idCategory = decodedData[i]["id_category"];
      categ.categoryName = decodedData[i]["category_name"];
      categ.categoryImage = decodedData[i]["category_img"];
      categ.categoryEstado = decodedData[i]["category_estado"];
      categories.add(categ);

      var subca = decodedData[i]["subcategorias"];

      if (subca.length > 0) {
        for (var x = 0; x < subca.length; x++) {
          SubCategoriesEntities subCateg = SubCategoriesEntities();
          subCateg.idSubCategory = subca[x]["id_subcategory"];
          subCateg.subCategoryName = subca[x]["subcategory_name"];
          subCateg.idCategory = subca[x]["id_category"];
          subCategories.add(subCateg);

          var itemSubca = subca[x]["itemsubcategorias"];

          if (itemSubca.length > 0) {
            for (var y = 0; y < itemSubca.length; y++) {
              ItemSubCateriesEntities itemSubCateg = ItemSubCateriesEntities();
              itemSubCateg.idItemSubCategory = itemSubca[y]["id_itemsubcategory"];
              itemSubCateg.nameItemSubCategory = itemSubca[y]["itemsubcategory_name"];
              itemSubCateg.imagenItemSubCategory = itemSubca[y]["itemsubcategory_img"];
              itemSubCateg.estadoItemSubCategory = itemSubca[y]["itemsubcategory_estado"];
              itemSubCateg.idSubCategory = itemSubca[y]["id_subcategory"];
              itemSubCategories.add(itemSubCateg);
            }
          }
        }
      }
    }
    final DataGeneralEntities returnGeneral = DataGeneralEntities(listCategories: categories, listSubCategories: subCategories, listItemSubCategories: itemSubCategories);
    // returnGeneral.listCategories = categories;
    // returnGeneral.listSubCategories = subCategories;
    // returnGeneral.listItemSubCategories = itemSubCategories;

    return returnGeneral;
  }
}
