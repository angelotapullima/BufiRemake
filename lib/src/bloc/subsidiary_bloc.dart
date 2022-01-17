import 'package:bufi_remake/src/api/company_api.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:rxdart/rxdart.dart';

class SubsidiaryBloc {
  final companyApi = CompanyApi();

  final _subsidiariesController = BehaviorSubject<List<SubsidiaryModel>>();
  final _subsidiaryIdController = BehaviorSubject<List<SubsidiaryModel>>();

  Stream<List<SubsidiaryModel>> get subsidiariesStream => _subsidiariesController.stream;
  Stream<List<SubsidiaryModel>> get subsidiaryIdStream => _subsidiaryIdController.stream;

  dispose() {
    _subsidiariesController.close();
    _subsidiaryIdController.close();
  }

  void obtenerSubsidiariesByIdCompany(String idCompany) async {
    _subsidiariesController.sink.add(await companyApi.subsidiaryDatabase.getSubsidiaryByIdCompany(idCompany));
    await companyApi.obtenerSucursalesByCompany(idCompany);
    _subsidiariesController.sink.add(await companyApi.subsidiaryDatabase.getSubsidiaryByIdCompany(idCompany));
  }

  void obtenerSubsidiariesByIdSubsidiary(String idSubsidiary) async {
    _subsidiaryIdController.sink.add(await companyApi.subsidiaryDatabase.getSubsidiaryByIdSubsidiary(idSubsidiary));
    await companyApi.obtenerSucursalesByIdSubsidiary(idSubsidiary);
    _subsidiaryIdController.sink.add(await companyApi.subsidiaryDatabase.getSubsidiaryByIdSubsidiary(idSubsidiary));
  }
}
