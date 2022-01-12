import 'package:bufi_remake/src/models/subsidiary_model.dart';

class CompanyModel {
  CompanyModel(
      {this.idCompany,
      this.idUser,
      this.idCity,
      this.idCategory,
      this.companyName,
      this.companyRuc,
      this.companyImage,
      this.companyType,
      this.companyShortcode,
      this.companyDeliveryPropio,
      this.companyDelivery,
      this.companyEntrega,
      this.companyTarjeta,
      this.companyVerified,
      this.companyRating,
      this.companyCreatedAt,
      this.companyJoin,
      this.companyStatus,
      this.companyMt,
      this.cityName,
      this.distancia,
      this.miNegocio,
      this.cell,
      this.direccion,
      this.favourite,
      this.sucursalPrincipal});

  String? idCompany;
  String? idUser;
  String? idCity;
  String? idCategory;
  String? companyName;
  String? companyRuc;
  String? companyImage;
  String? companyType;
  String? companyShortcode;
  String? companyDeliveryPropio;
  String? companyDelivery;
  String? companyEntrega;
  String? companyTarjeta;
  String? companyVerified;
  String? companyRating;
  String? companyCreatedAt;
  String? companyJoin;
  String? companyStatus;
  String? companyMt;
  String? idCountry;
  String? cityName;
  String? distancia;
  String? miNegocio;
  String? favourite;
  String? cell;
  String? direccion;
  SubsidiaryModel? sucursalPrincipal;

  static List<CompanyModel> fromJsonList(List<dynamic> json) => json.map((i) => CompanyModel.fromJson(i)).toList();

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        idCompany: json["idCompany"],
        idUser: json["idUser"],
        idCity: json["idCity"],
        idCategory: json["idCategory"],
        companyName: json["companyName"],
        companyRuc: json["companyRuc"],
        companyImage: json["companyImage"],
        companyType: json["companyType"],
        companyShortcode: json["companyShortcode"],
        companyDeliveryPropio: json["companyDeliveryPropio"],
        companyDelivery: json["companyDelivery"],
        companyEntrega: json["companyEntrega"],
        companyTarjeta: json["companyTarjeta"],
        companyVerified: json["companyVerified"],
        companyRating: json["companyRating"],
        companyCreatedAt: json["companyCreatedAt"],
        companyJoin: json["companyJoin"],
        companyStatus: json["companyStatus"],
        companyMt: json["companyMt"],
        cityName: json["cityName"],
        distancia: json["distancia"],
        miNegocio: json["miNegocio"],
      );

  Map<String, dynamic> toJson() => {
        "idCompany": idCompany,
        "idUser": idUser,
        "idCity": idCity,
        "idCategory": idCategory,
        "companyName": companyName,
        "companyRuc": companyRuc,
        "companyImage": companyImage,
        "companyType": companyType,
        "companyShortcode": companyShortcode,
        "companyDelivery": companyDelivery,
        "companyEntrega": companyEntrega,
        "companyTarjeta": companyTarjeta,
        "companyVerified": companyVerified,
        "companyRating": companyRating,
        "companyCreatedAt": companyCreatedAt,
        "companyJoin": companyJoin,
        "companyStatus": companyStatus,
        "companyMt": companyMt,
        "miNegocio": miNegocio,
      };
}
