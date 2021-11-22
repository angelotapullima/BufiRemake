import 'package:bloc/bloc.dart';
import 'package:bufi_remake/core/error/failures.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/itemSubCategoriesModel.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/subCategoriesModel.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/usecases/get_productitemSubCategory.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/usecases/get_productsCategory.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/usecases/get_productsSubcategory.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetProductsCategory getProductsCategory;
  final GetProductsSubCategory getProductsSubCategory;
  final GetProductsItemSubCategory getProductsItemSubCategory;

  CategoriesBloc({required this.getProductsItemSubCategory, required this.getProductsSubCategory, required this.getProductsCategory}) : super(ProductscategoryInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
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
    }else if (event is GetItemSubCategoriesBlocEvent) {
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
          yield ListaItemSubCategorias(listItemSubCategories: success, nombreSubCategoria: '${event.nombreSubCategoria}',idCategory: '${event.idCategory}');
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
