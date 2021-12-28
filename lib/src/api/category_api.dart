import 'dart:convert';

import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/src/database/category_database.dart';
import 'package:bufi_remake/src/database/item_sub_category_database.dart';
import 'package:bufi_remake/src/database/sub_category_database.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final categoryDatabase = CategoryDatabase();
  final subcategoryDatabase = SubCategoryDatabase();
  final itemsubcategoryDatabase = ItemSubCategoryDatabase();
  Future<int> obtenerCatory() async {
    try {
      final url = '$API_BASE_URL/api/Inicio/listar_categorias';
      final response = await http.post(Uri.parse(url), body: {});

      final decodedData = json.decode(response.body);

      for (var i = 0; i < decodedData.length; i++) {
        CategoryModel category = CategoryModel();

        category.idCategory = decodedData[i]["id_category"];
        category.categoryName = decodedData[i]["category_name"];
        category.categoryEstado = decodedData[i]["category_estado"];
        category.categoryImage = decodedData[i]["category_img"];
        await categoryDatabase.insertCategories(category);

        for (var x = 0; x < decodedData[i]["subcategorias"].length; x++) {
          var subcat = decodedData[i]["subcategorias"][x];
          SubCategoryModel subcategory = SubCategoryModel();
          subcategory.idSubCategory = subcat["id_subcategory"];
          subcategory.nameSubCategory = subcat["subcategory_name"];
          subcategory.idCategory = subcat["id_category"];

          await subcategoryDatabase.insertSubCategories(subcategory);

          for (var y = 0; y < subcat["itemsubcategorias"].length; y++) {
            var itemsubc = subcat["itemsubcategorias"][y];

            ItemSubCategoryModel itemsubcategory = ItemSubCategoryModel();
            itemsubcategory.idItemSubCategory = itemsubc["id_itemsubcategory"];
            itemsubcategory.nameItemSubCategory = itemsubc["itemsubcategory_name"];
            itemsubcategory.estadoItemSubCategory = itemsubc["itemsubcategory_estado"];
            itemsubcategory.imagenItemSubCategory = itemsubc["itemsubcategory_img"];
            itemsubcategory.idSubCategory = itemsubc["id_subcategory"];

            await itemsubcategoryDatabase.insertItemSubCategories(itemsubcategory);
          }
        }
      }
      return 1;
    } catch (e) {
      return 2;
    }
  }
}
