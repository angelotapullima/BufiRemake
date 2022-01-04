import 'package:bufi_remake/src/bloc/category_bloc.dart';
import 'package:bufi_remake/src/bloc/company_bloc.dart';
import 'package:bufi_remake/src/bloc/pantalla_principal_bloc.dart';
import 'package:bufi_remake/src/bloc/productos_bloc.dart';
import 'package:bufi_remake/src/bloc/publicidad_bloc.dart';
import 'package:bufi_remake/src/bloc/servicios_bloc.dart';
import 'package:flutter/cupertino.dart';

class ProviderBloc extends InheritedWidget {
  final publicidadBloc = PublicidadBloc();
  final pantallaPrincipalBloc = PantallaPrincipalBloc();
  final categoryBloc = CategoryBloc();
  final companyBloc = CompanyBloc();
  final productosBloc = ProductosBloc();
  final serviciosBloc = ServiciosBloc();
  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PublicidadBloc publi(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.publicidadBloc;
  }

  static PantallaPrincipalBloc pantalla(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.pantallaPrincipalBloc;
  }

  static CategoryBloc category(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.categoryBloc;
  }

  static CompanyBloc company(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.companyBloc;
  }

  static ProductosBloc producto(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.productosBloc;
  }

  static ServiciosBloc servicios(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.serviciosBloc;
  }
}
