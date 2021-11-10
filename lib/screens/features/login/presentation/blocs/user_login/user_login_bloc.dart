import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/core/usecases/fetch_token.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:bufi_remake/screens/features/login/domain/usecases/login_user.dart';

import 'bloc.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginUser loginUser;
  final FetchToken fetchToken;

  UserLoginBloc({required this.fetchToken, required this.loginUser}) : super(NotLoggedState());

  UserLoginState get initialState => NotLoggedState();

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    if (event is CheckLoginStatusEvent) {
      yield LoadingState();
      final result = await fetchToken(TokenParams());
      yield* result.fold((failure) async* {
        if (failure is ApiError) {
          yield ErrorState(message: failure.message);
        } else {
          yield NotLoggedState();
        }
      }, (success) async* {
        yield LoggedState(code: '1');
      });
    } else if (event is LoginEvent) {
      yield LoadingState();
      final result = await loginUser(LoginParams(email: event.email, password: event.password));
      yield* result.fold((failure) async* {
        if (failure is NoConnectionFailure) {
          yield ErrorState(message: NO_CONNECTION_ERROR);
        } else if (failure is ApiError) {
          yield ErrorState(message: failure.message);
        } else {
          yield ErrorState(message: LOGGING_ERROR);
        }
      }, (success) async* {
        yield LoggedState(code: success.code);
      });
    } else if (event is SkipLoginEvent) {
      yield LoggedState(code: '112');
    }
  }
}
