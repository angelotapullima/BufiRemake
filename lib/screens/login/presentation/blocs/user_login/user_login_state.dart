import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginState extends Equatable {
  @override
  List<Object> get props => [];
}

//Estado de no logueado
class NotLoggedState extends UserLoginState {}

//estado de login cargando
class LoadingState extends UserLoginState {}

//estado de logueado
class LoggedState extends UserLoginState {
  final String? code;

  LoggedState({@required this.code});

  @override
  List<Object> get props => [code!];
}

//estdo de error en el logueo
class ErrorState extends UserLoginState {
  final String? message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message!];
}
