/* import 'dart:convert';

import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/dataGeneralEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/subCategoriesEntities.dart';
import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:http/http.dart' as http;

abstract class ProXItemSubRemoteDataSource {
  Future<DataGeneralEntities> getCategories();
}

class ProXItemSubRemoteDataSourceImpl implements ProXItemSubRemoteDataSource {
  final http.Client? client;
/*  */
  ProXItemSubRemoteDataSourceImpl({required this.client});

  @override
  Future<DataGeneralEntities> getCategories() async {
    final List<CategoriesEntities> categories = [];
    final List<SubCategoriesEntities> subCategories = [];
    final List<ItemSubCateriesEntities> itemSubCategories = [];
    final url = '$API_BASE_URL/api/Inicio/listar_bienes_por_id_itemsubca';

    final response = await client!.post(Uri.parse(url), body: {
      'id_ciudad': '1',
    });
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final decodedData = json.decode(response.body);

    
    final DataGeneralEntities returnGeneral =
        DataGeneralEntities(listCategories: categories, listSubCategories: subCategories, listItemSubCategories: itemSubCategories);
    // returnGeneral.listCategories = categories;
    // returnGeneral.listSubCategories = subCategories;
    // returnGeneral.listItemSubCategories = itemSubCategories;

    return returnGeneral;
  }
}
 */