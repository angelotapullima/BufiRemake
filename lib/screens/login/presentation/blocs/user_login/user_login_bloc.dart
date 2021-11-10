import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/screens/login/domain/usecases/login_user.dart'; 

import 'bloc.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginUser loginUser;

  UserLoginBloc({required this.loginUser}) : super(NotLoggedState());

  UserLoginState get initialState => NotLoggedState();

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    if (event is CheckLoginStatusEvent) {
      yield LoadingState();
      yield NotLoggedState();
    } else if (event is LoginEvent) {
      yield LoadingState();
      final result = await loginUser(LoginParams(email: event.email, password: event.password));
      yield* result.fold((failure) async* {
        if (failure is NoConnectionFailure) {
          yield ErrorState(message: NO_CONNECTION_ERROR);
        } else {
          yield ErrorState(message: LOGGING_ERROR);
        }
      }, (success) async* {
        yield LoggedState(code: success);
      });
    } else if (event is SkipLoginEvent) {
      yield LoggedState(code: '112');
    }
  }
}
