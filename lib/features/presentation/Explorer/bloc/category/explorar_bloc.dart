


import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/features/data/models/Explorar/ItemSubcategory/itemSubCategoriesModel.dart';
import 'package:bufi_remake/features/data/models/Explorar/SubCategory/subCategoriesModel.dart';
import 'package:bufi_remake/features/domain/entities/Explorer/categoriesEntities.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_category.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_itemSubCategory.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_subcategory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'explorar_event.dart';
part 'explorar_state.dart';

class ExplorarBloc extends Bloc<ExplorarEvent, ExplorarState> {
  final GetCategory getProductsCategory;
  final GetSubCategory getProductsSubCategory;
  final GetItemSubCategory getProductsItemSubCategory;

  ExplorarBloc({
    required this.getProductsItemSubCategory,
    required this.getProductsSubCategory,
    required this.getProductsCategory,
  }) : super(
          ProductscategoryInitial(),
        );

  @override
  Stream<ExplorarState> mapEventToState(
    ExplorarEvent event,
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
          yield ListaCategorias(listCategories: success);
        } else {
          yield Empty();
        }
      });
    } else if (event is GetSubCategoriesBlocEvent) {
      final res = await getProductsSubCategory(SubcategoryParams(idCategory: event.idCategory));

      yield* res.fold((failure) async* {
        if (failure is NoConnectionFailure) {
          yield Error(message: _mapFailureToMessage(failure));
        } else if (failure is ApiError) {
          yield Error(message: _mapFailureToMessage(failure));
        } else {
          yield Error(message: _mapFailureToMessage(failure));
        }
      }, (success) async* {
        if (success.length > 0) {
          yield ListaSubCategorias(listSubCategories: success, nombreCategoria: '${event.nombreCategoria}');
        } else {
          yield Empty();
        }
      });
    } else if (event is GetItemSubCategoriesBlocEvent) {
      final res = await getProductsItemSubCategory(ItemSubcategoryParams(idSubCategory: event.idSubCategory));

      yield* res.fold((failure) async* {
        if (failure is NoConnectionFailure) {
          yield Error(message: _mapFailureToMessage(failure));
        } else if (failure is ApiError) {
          yield Error(message: _mapFailureToMessage(failure));
        } else {
          yield Error(message: _mapFailureToMessage(failure));
        }
      }, (success) async* {
        if (success.length > 0) {
          yield ListaItemSubCategorias(
              listItemSubCategories: success, nombreSubCategoria: '${event.nombreSubCategoria}', idCategory: '${event.idCategory}');
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
