import 'package:bufi_remake/src/api/publicidad_api.dart';
import 'package:bufi_remake/src/models/publicidad_model.dart';
import 'package:rxdart/rxdart.dart';

class PublicidadBloc {
  final _publicidadApi = PublicidadApi();

  final _publicidadController = BehaviorSubject<List<PublicidadModel>>();
  Stream<List<PublicidadModel>> get publicidadStream => _publicidadController.stream;

  dispose() {
    _publicidadController.close();
  }

  void obtenerPublicidad() async {
    _publicidadController.sink.add([]);
    await _publicidadApi.obtenerPublicidad();
    _publicidadController.sink.add(await _publicidadApi.publicidadDatabase.getPublicidad());
  }
}
