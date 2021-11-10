import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/usecases/get_productsCategory.dart';
 
import 'package:equatable/equatable.dart';
part 'productscategory_event.dart';
part 'productscategory_state.dart';

class ProductscategoryBloc extends Bloc<ProductscategoryEvent, ProductscategoryState> {
  final GetProductsCategory getProductsCategory;
  ProductscategoryBloc({required this.getProductsCategory}) : super(ProductscategoryInitial());
  @override
  Stream<ProductscategoryState> mapEventToState(
    ProductscategoryEvent event,
  ) async* {
    if (event is GetCategoriesBlocEvent) {
      yield Loading();
      final result = await getProductsCategory(TokenParams());

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
          yield Loaded(listCategories: success);
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
