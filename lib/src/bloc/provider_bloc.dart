import 'package:bufi_remake/src/bloc/publicidad_bloc.dart';
import 'package:flutter/cupertino.dart';

class ProviderBloc extends InheritedWidget {
  final publicidadBloc = PublicidadBloc();
  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PublicidadBloc publi(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.publicidadBloc;
  }
}
