import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class LoginEvent extends UserLoginEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SkipLoginEvent extends UserLoginEvent {}
