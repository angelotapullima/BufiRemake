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

      SubCategoriesEntities subCateg = SubCategoriesEntities();
      subCateg.idSubCategory = decodedData[i]["id_subcategory"];
      subCateg.subCategoryName = decodedData[i]["subcategory_name"];
      subCateg.idCategory = decodedData[i]["id_category"];
      subCategories.add(subCateg);

      ItemSubCateriesEntities itemSubCateg = ItemSubCateriesEntities();
      itemSubCateg.idItemSubCategory = decodedData[i]["id_itemsubcategory"];
      itemSubCateg.nameItemSubCategory = decodedData[i]["itemsubcategory_name"];
      itemSubCateg.imagenItemSubCategory = decodedData[i]["itemsubcategory_img"];
      itemSubCateg.estadoItemSubCategory = decodedData[i]["itemsubcategory_estado"];
      itemSubCateg.idSubCategory = decodedData[i]["id_subcategory"];
      itemSubCategories.add(itemSubCateg);
    }
    final DataGeneralEntities returnGeneral =
        DataGeneralEntities(listCategories: categories, listSubCategories: subCategories, listItemSubCategories: itemSubCategories);
    // returnGeneral.listCategories = categories;
    // returnGeneral.listSubCategories = subCategories;
    // returnGeneral.listItemSubCategories = itemSubCategories;

    return returnGeneral;
  }
}
