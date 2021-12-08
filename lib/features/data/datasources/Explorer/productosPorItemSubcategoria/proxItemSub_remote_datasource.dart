import 'dart:convert';


import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/features/data/models/Explorer/ProductoPorItemSubcategoria/productoModel.dart';
import 'package:http/http.dart' as http;

abstract class ProXItemSubRemoteDataSource {
  Future<List<ProductoModel>> getProductsForItemSub(String idItemSubCategory);
}

class ProXItemSubRemoteDataSourceImpl implements ProXItemSubRemoteDataSource {
  final http.Client? client;
/*  */
  ProXItemSubRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductoModel>> getProductsForItemSub(String idItemSubCategory) async {
    final List<ProductoModel> listGeneral = [];
   
    final url = '$API_BASE_URL/api/Inicio/listar_bienes_por_id_itemsubca';

    final response = await client!.post(Uri.parse(url), body: {
      'id_ciudad': '1','id_itemsubcategoria': '$idItemSubCategory','app':'true'
    });
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final decodedData = json.decode(response.body);

   

    return listGeneral;
  }
}