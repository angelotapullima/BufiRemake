// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'package:bufi_remake/screens/login/domain/entities/login.dart';

class LoginModel extends LoginEntities {
  LoginModel(
      {required String? cU,
      required String? idBufipay,
      required String? n,
      required String? uE,
      required String? uI,
      required String? pC,
      required String? pU,
      required String? pN,
      required String? pP,
      required String? pM,
      required String? pS,
      required String? pD,
      required String? ru,
      required String? rn,
      required String? tn})
      : super(
          cU: cU,
          idBufipay: idBufipay,
          n: n,
          uE: uE,
          uI: uI,
          pC: pC,
          pU: pU,
          pN: pN,
          pP: pP,
          pM: pM,
          pS: pS,
          pD: pD,
          ru: ru,
          rn: rn,
          tn: tn,
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        cU: json["c_u"],
        idBufipay: json["id_bufipay"],
        n: json["_n"],
        uE: json["u_e"],
        uI: json["u_i"],
        pC: json["p_c"],
        pU: json["p_u"],
        pN: json["p_n"],
        pP: json["p_p"],
        pM: json["p_m"],
        pS: json["p_s"],
        pD: json["p_d"],
        ru: json["ru"],
        rn: json["rn"],
        tn: json["tn"],
      );

  Map<String, dynamic> toJson() => {
        "c_u": cU,
        "id_bufipay": idBufipay,
        "_n": n,
        "u_e": uE,
        "u_i": uI,
        "p_c": pC,
        "p_u": pU,
        "p_n": pN,
        "p_p": pP,
        "p_m": pM,
        "p_s": pS,
        "p_d": pD,
        "ru": ru,
        "rn": rn,
        "tn": tn,
      };
}
