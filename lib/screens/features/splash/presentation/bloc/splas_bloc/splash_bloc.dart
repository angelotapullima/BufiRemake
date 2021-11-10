import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bufi_remake/screens/features/splash/domain/usecases/fetch_token.dart';
import 'package:equatable/equatable.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final FetchToken fetchToken;
  SplashBloc({
    required this.fetchToken,
  }) : super(NotLoggedState());
  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is CheckLoginStatusEvent) {
      yield NotLoggedState();
      final result = await fetchToken(TokenParams());
      yield* result.fold((failure) async* {
        yield NotLoggedState();
      }, (success) async* {
        yield LoggedState(code: '1');
      });
    }
  }
}
