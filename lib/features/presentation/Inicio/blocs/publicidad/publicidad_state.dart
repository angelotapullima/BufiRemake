part of 'publicidad_bloc.dart';

abstract class PublicidadState extends Equatable {
  @override
  List<Object> get props => [];
}

class PublicidadInitial extends PublicidadState {}

class Empty extends PublicidadState {}

class Loading extends PublicidadState {}

class ListarPublicidad extends PublicidadState {
  final List<PublicidadEntities> listPublicidad;

  ListarPublicidad({required this.listPublicidad});

  @override
  List<Object> get props => [listPublicidad];
}

class Error extends PublicidadState {
  final String message;
  Error({required this.message});

  @override
  List<Object> get props => [message];
}
