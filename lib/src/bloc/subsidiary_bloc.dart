import 'package:bufi_remake/src/database/subsidiary_database.dart';
import 'package:bufi_remake/src/models/subsidiary_model.dart';
import 'package:rxdart/rxdart.dart';

class SubsidiaryBloc {
  final subsidiaryDatabase = SubsidiaryDatabase();
  final _subsidiariesController = BehaviorSubject<List<SubsidiaryModel>>();

  Stream<List<SubsidiaryModel>> get subsidiariesStream => _subsidiariesController.stream;

  dispose() {
    _subsidiariesController.close();
  }

  void obtenerSubsidiariesByIdCompany(String idCompany) async {
    _subsidiariesController.sink.add(await subsidiaryDatabase.getSubsidiaryByIdCompany(idCompany));
  }
}
