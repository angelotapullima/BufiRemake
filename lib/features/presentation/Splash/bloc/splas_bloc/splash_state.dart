part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

//Estado de no logueado
class NotLoggedState extends SplashState {}

class LoggedState extends SplashState {
  final String? code;

  LoggedState({required this.code});

  @override
  List<Object> get props => [code!];
}
