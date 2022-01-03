import 'package:bufi_remake/src/api/servicios_api.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:rxdart/rxdart.dart';

class ServiciosBloc {
  final servicioApi = ServiciosApi();

  final _servicioController = BehaviorSubject<List<ServicioModel>>();
  Stream<List<ServicioModel>> get servicioStream => _servicioController.stream;

  void dispose() {
    _servicioController.close();
  }

  void obtenerServiciosPorIdItemSubcategory(String id) async {
    _servicioController.sink.add(await servicioApi.servicioDatabase.getServiciosPorIdItemSubCategoria(id));
    await servicioApi.obtenerServiciosPorCiudad();
    _servicioController.sink.add(await servicioApi.servicioDatabase.getServiciosPorIdItemSubCategoria(id));
  }
}
