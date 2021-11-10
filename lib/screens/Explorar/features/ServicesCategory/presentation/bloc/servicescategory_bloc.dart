import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'servicescategory_event.dart';
part 'servicescategory_state.dart';
class ServicescategoryBloc extends Bloc<ServicescategoryEvent, ServicescategoryState> {
  ServicescategoryBloc() : super(ServicescategoryInitial());
  @override
  Stream<ServicescategoryState> mapEventToState(
    ServicescategoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
