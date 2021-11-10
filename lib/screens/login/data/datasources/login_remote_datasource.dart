import 'dart:convert';


import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  Future<String> loginUser3(String? email, String? password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client? client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<String> loginUser3(String? email, String? password) async {
    final url = '$API_BASE_URL/api/Login/validar_sesion';

    final response = await client!.post(Uri.parse(url), body: {
      'usuario_nickname': email,
      'usuario_contrasenha': password,
      'app': 'true',
    });
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final decodedData = json.decode(response.body);
    final int code = decodedData['result']['code'];
    if (code != 1) {
      throw ServerException();
    }


    return code.toString();
  }
}
