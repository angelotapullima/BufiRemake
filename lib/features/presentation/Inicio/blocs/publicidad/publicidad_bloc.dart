import 'package:bloc/bloc.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/domain/entities/Inicio/publicidadEntities.dart';
import 'package:bufi_remake/features/domain/usecases/Inicio/get_publicidad.dart';
import 'package:bufi_remake/features/presentation/Explorer/bloc/Category/explorer_bloc.dart';
import 'package:equatable/equatable.dart';

part 'publicidad_event.dart';
part 'publicidad_state.dart';

class PublicidadBloc extends Bloc<PublicidadEvent, PublicidadState> {
  final GetPublicidad getPublicidad;
  PublicidadBloc({required this.getPublicidad}) : super(PublicidadInitial());

  @override
  Stream<PublicidadState> mapEventToState(PublicidadEvent event) async* {
    if (event is GetCategoriesBlocEvent) {
      yield Loading();
      final result = await getPublicidad(PublicidadParams());

      yield* result.fold((failure) async* {
        if (failure is NoConnectionFailure) {
          yield Error(message: _mapFailureToMessage(failure));
        } else if (failure is ApiError) {
          yield Error(message: _mapFailureToMessage(failure));
        } else {
          yield Error(message: _mapFailureToMessage(failure));
        }
      }, (success) async* {
        if (success.length > 0) {
          yield ListarPublicidad(listPublicidad: success);
        } else {
          yield Empty();
        }
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected error';
    }
  }
}
