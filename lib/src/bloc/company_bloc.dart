import 'package:bufi_remake/src/api/company_api.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc {
  final companyApi = CompanyApi();

  final _companyController = BehaviorSubject<List<CompanyModel>>();
  final _companyIdController = BehaviorSubject<List<CompanyModel>>();

  Stream<List<CompanyModel>> get companyStream => _companyController.stream;
  Stream<List<CompanyModel>> get companyIdStream => _companyIdController.stream;

  void listarCompanies() async {
    _companyController.sink.add(await companyApi.companyDatabase.getCompanies());
    await companyApi.obtenerCompanies();
    _companyController.sink.add(await companyApi.companyDatabase.getCompanies());
  }

  void obtenerNegocioById(String id) async {
    _companyIdController.sink.add(await getCompanyById(id));
    await companyApi.obtenerCompanyById(id);
    _companyIdController.sink.add(await getCompanyById(id));
  }

  Future<List<CompanyModel>> getCompanyById(String id) async {
    try {
      final List<CompanyModel> listaCompany = [];
      final companyDB = await companyApi.companyDatabase.getCompaniesByIdCompany(id);
      if (companyDB.length > 0) {
        CompanyModel company = CompanyModel();
        company.idCompany = companyDB[0].idCompany;
        company.idUser = companyDB[0].idUser;
        company.idCity = companyDB[0].idCity;
        company.idCategory = companyDB[0].idCategory;
        company.companyName = companyDB[0].companyName;
        company.companyRuc = companyDB[0].companyRuc;
        company.companyImage = companyDB[0].companyImage;
        company.companyType = companyDB[0].companyType;
        company.companyShortcode = companyDB[0].companyShortcode;
        company.companyDeliveryPropio = companyDB[0].companyDeliveryPropio;
        company.companyDelivery = companyDB[0].companyDelivery;
        company.companyEntrega = companyDB[0].companyEntrega;
        company.companyTarjeta = companyDB[0].companyTarjeta;
        company.companyVerified = companyDB[0].companyVerified;
        company.companyRating = companyDB[0].companyRating;
        company.companyCreatedAt = companyDB[0].companyCreatedAt;
        company.companyJoin = companyDB[0].companyJoin;
        company.companyStatus = companyDB[0].companyStatus;
        company.companyMt = companyDB[0].companyMt;
        company.cityName = companyDB[0].cityName;
        company.distancia = companyDB[0].distancia;
        company.miNegocio = companyDB[0].miNegocio;
        company.cell = companyDB[0].cell;
        company.direccion = companyDB[0].direccion;
        company.favourite = companyDB[0].favourite;

        final subsidiaryDB = await companyApi.subsidiaryDatabase.getSubsidiaryPrincipalByIdCompany(companyDB[0].idCompany.toString());
        if (subsidiaryDB.length > 0) {
          company.sucursalPrincipal = subsidiaryDB[0];
        }

        listaCompany.add(company);
      }
      return listaCompany;
    } catch (e) {
      print(e);
      return [];
    }
  }

  dispose() {
    _companyController.close();
    _companyIdController.close();
  }
}
