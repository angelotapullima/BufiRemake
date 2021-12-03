import 'dart:convert';

import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/features/domain/entities/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  Future<Login> loginUser3(String? email, String? password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client? client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<Login> loginUser3(String? email, String? password) async {
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

    Login log = Login();
    log.code = code.toString();
    log.message = decodedData['result']['message'];

    LoginEntities login = LoginEntities();
    if (code == 1) {
      login.cU = decodedData['data']['c_u'];

      login.idBufipay = decodedData['data']['id_bufipay'];
      login.n = decodedData['data']['_n'];
      login.uE = decodedData['data']['u_e'];
      login.uI = decodedData['data']['u_i'];
      login.pC = decodedData['data']['p_c'];
      login.pU = decodedData['data']['p_u'];
      login.pN = decodedData['data']['p_n'];
      login.pP = decodedData['data']['p_p'];
      login.pM = decodedData['data']['p_m'];
      login.pS = decodedData['data']['p_s'];
      login.pD = decodedData['data']['p_d'];
      login.ru = decodedData['data']['ru'];
      login.rn = decodedData['data']['rn'];
      login.tn = decodedData['data']['tn'];
    }

    log.loginEntities = login;

    return log;
  }
}
