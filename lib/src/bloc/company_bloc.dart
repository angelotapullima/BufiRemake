import 'package:bufi_remake/src/api/company_api.dart';
import 'package:bufi_remake/src/models/company_model.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc {
  final companyApi = CompanyApi();

  final _companyController = BehaviorSubject<List<CompanyModel>>();

  Stream<List<CompanyModel>> get companyStream => _companyController.stream;

  void listarCompanies() async {
    _companyController.sink.add(await companyApi.companyDatabase.getCompanies());
    await companyApi.obtenerCompanies();
    _companyController.sink.add(await companyApi.companyDatabase.getCompanies());
  }

  dispose() {
    _companyController.close();
  }
}
