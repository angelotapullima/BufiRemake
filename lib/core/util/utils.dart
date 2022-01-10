import 'dart:math';

import 'package:bufi_remake/src/bloc/provider_bloc.dart';
import 'package:bufi_remake/src/database/productos_database.dart';
import 'package:bufi_remake/src/database/servicios_database.dart';
import 'package:bufi_remake/src/database/subsidiary_database.dart';
import 'package:bufi_remake/src/models/productos_model.dart';
import 'package:bufi_remake/src/models/servicio_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  double screenSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  double screenSafeAreaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left - MediaQuery.of(context).padding.right;
  }

  Color randomColor() => Color(Random().nextInt(0xffffffff)).withAlpha(0xff);

  BorderRadius buildBorderRadius() {
    return BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20));
  }

  String prepareLists(List<String> list) {
    String result = "";
    if (list.isNotEmpty) {
      for (var person in list) {
        result = result + person.toString().split("/")[person.toString().split("/").length - 2] + ",";
      }
      result = result.substring(0, (result.length) - 1).replaceAll(",", "\n");
    } else {
      result = " - ";
    }
    return result;
  }
}

void showToast2(String? texto, Color color) {
  Fluttertoast.showToast(msg: "$texto", toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

void actualizarPointProducto(BuildContext context, ProductoModel producto, String point) async {
  final _productoDatabase = ProductosDatabase();
  final _subsidiaryDatabase = SubsidiaryDatabase();
  await _productoDatabase.updatePoint(producto.idProducto.toString(), point);
  await _subsidiaryDatabase.updatePoint(producto.idSubsidiary.toString(), point);
  final pantallaBloc = ProviderBloc.pantalla(context);
  final favoritoBloc = ProviderBloc.favoritos(context);
  final productosBloc = ProviderBloc.producto(context);

  pantallaBloc.obtenerPantallaPrincipal();
  productosBloc.obtenerProductosByItemSubcategory(producto.idItemsubcategory.toString());
  favoritoBloc.update();
}

void actualizarPointServicio(BuildContext context, ServicioModel servicio, String point) async {
  print('Presionar Servicio favorito');
  final _servicioDatabase = ServiciosDatabase();
  final _subsidiaryDatabase = SubsidiaryDatabase();
  await _servicioDatabase.updatePoint(servicio.idServicio.toString(), point);
  await _subsidiaryDatabase.updatePoint(servicio.idSubsidiary.toString(), point);
  final favoritoBloc = ProviderBloc.favoritos(context);
  final servicesBloc = ProviderBloc.servicios(context);

  servicesBloc.obtenerServiciosPorIdItemSubcategory(servicio.idItemsubcategory.toString());
  favoritoBloc.update();
}
