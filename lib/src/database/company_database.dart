import 'package:bufi_remake/core/database/databd_config.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:sqflite/sqflite.dart';

class CompanyDatabase {
  final dbprovider = DatabaseHelper.instance;
  Future<void> insertCompany(CompanyModel company) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert("INSERT OR REPLACE INTO Company(idCompany,idUser,idCity,idCategory,companyName,companyRuc,"
          "companyImage,companyType,companyShortcode,companyDeliveryPropio,companyDelivery,companyEntrega,companyTarjeta,"
          "companyVerified,companyRating,companyCreatedAt,companyJoin,companyStatus,miNegocio) "
          "VALUES('${company.idCompany}', '${company.idUser}', '${company.idCity}', '${company.idCategory}', "
          "'${company.companyName}', '${company.companyRuc}', '${company.companyImage}', '${company.companyType}', "
          "'${company.companyShortcode}', '${company.companyDeliveryPropio}','${company.companyDelivery}', '${company.companyEntrega}', "
          "'${company.companyTarjeta}', '${company.companyVerified}', '${company.companyRating}', "
          "'${company.companyCreatedAt}', '${company.companyJoin}', '${company.companyStatus}', '${company.miNegocio}')");
    } catch (e) {
      print('Error al insertar en la base de datos Company: $e');
    }
  }

  Future<List<CompanyModel>> getCompanies() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CompanyModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Company ORDER BY cast(idCompany as int)");
      if (maps.length > 0) list = CompanyModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Company: $e');
      return [];
    }
  }

  Future<List<CompanyModel>> getCompaniesByIdCompany(String idCompany) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CompanyModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Company WHERE idCompany='$idCompany'");
      if (maps.length > 0) list = CompanyModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print('Error al consultar en la base de datos Company: $e');
      return [];
    }
  }
}
