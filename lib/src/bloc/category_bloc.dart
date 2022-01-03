import 'package:bufi_remake/src/api/bienes_api.dart';
import 'package:bufi_remake/src/api/category_api.dart';
import 'package:bufi_remake/src/api/servicios_api.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final categoryApi = CategoryApi();

  //----------------- Productos ------------------------------------------
  final _categoryController = BehaviorSubject<List<CategoryModel>>();
  final _subCategoryController = BehaviorSubject<List<SubCategoryModel>>();
  final _itemsubcategoryController = BehaviorSubject<List<ItemSubCategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream => _categoryController.stream;
  Stream<List<SubCategoryModel>> get subcategoryStream => _subCategoryController.stream;
  Stream<List<ItemSubCategoryModel>> get itemsubcategoryStream => _itemsubcategoryController.stream;

  //-----------------------------------------------------------------------

  //----------------- Servicios ------------------------------------------
  final _categoryServiceController = BehaviorSubject<List<CategoryModel>>();
  final _subCategoryServiceController = BehaviorSubject<List<SubCategoryModel>>();
  final _itemsubcategoryServiceController = BehaviorSubject<List<ItemSubCategoryModel>>();

  Stream<List<CategoryModel>> get categoryServiceStream => _categoryServiceController.stream;
  Stream<List<SubCategoryModel>> get subcategoryServiceStream => _subCategoryServiceController.stream;
  Stream<List<ItemSubCategoryModel>> get itemsubcategoryServiceStream => _itemsubcategoryServiceController.stream;

  //-----------------------------------------------------------------------

  dispose() {
    _categoryController.close();
    _subCategoryController.close();
    _itemsubcategoryController.close();
    _categoryServiceController.close();
    _subCategoryServiceController.close();
    _itemsubcategoryServiceController.close();
  }

  void obtenerCategories() async {
    _categoryController.sink.add(await getCategories());
    await categoryApi.obtenerCatory();
    _categoryController.sink.add(await getCategories());
  }

  void obtenerSubcatgories(String idCategory) async {
    _subCategoryController.sink.add(await getSubCategories(idCategory));
  }

  void obtenerItemsubcategories(String idSubcategory) async {
    _itemsubcategoryController.sink.add(await getItemSubCategories(idSubcategory));
  }

  void cleanStreamSubCategory() {
    _subCategoryController.sink.add([]);
  }

  void cleanStreamItemSubCategory() {
    _itemsubcategoryController.sink.add([]);
  }

  void obtenerCategoriesService() async {
    _categoryServiceController.sink.add(await getCategoriesService());
    await categoryApi.obtenerCatory();
    _categoryServiceController.sink.add(await getCategoriesService());
  }

  void obtenerSubcatgoriesServices(String idCategory) async {
    _subCategoryServiceController.sink.add(await getSubCategoriesService(idCategory));
  }

  void obtenerItemsubcategoriesService(String idSubcategory) async {
    _itemsubcategoryServiceController.sink.add(await getItemSubCategoriesService(idSubcategory));
  }

  void cleanStreamSubCategoryService() {
    _subCategoryServiceController.sink.add([]);
  }

  void cleanStreamItemSubCategoryService() {
    _itemsubcategoryServiceController.sink.add([]);
  }

  Future<List<CategoryModel>> getCategories() async {
    final productosApi = BienesApi();
    await productosApi.obtenerBienesPorCity();
    final List<CategoryModel> lista = [];

    final listaCategories = await categoryApi.categoryDatabase.getCategories();

    for (var i = 0; i < listaCategories.length; i++) {
      int contador = 0;

      final listSubCategories = await categoryApi.subcategoryDatabase.getSubCategoriesByIdCategory(listaCategories[i].idCategory.toString());

      for (var x = 0; x < listSubCategories.length; x++) {
        final listItems =
            await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(listSubCategories[x].idSubCategory.toString());
        for (var y = 0; y < listItems.length; y++) {
          final listProductos = await productosApi.productoDatabase.getProductosByIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
          if (listProductos.length > 0) {
            contador++;
          }
        }
      }

      if (contador > 0) {
        lista.add(listaCategories[i]);
      }
    }

    return lista;
  }

  Future<List<SubCategoryModel>> getSubCategories(String idCategory) async {
    final productosApi = BienesApi();
    final List<SubCategoryModel> lista = [];

    final listSubCategories = await categoryApi.subcategoryDatabase.getSubCategoriesByIdCategory(idCategory);

    for (var x = 0; x < listSubCategories.length; x++) {
      int contador = 0;
      final listItems = await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(listSubCategories[x].idSubCategory.toString());
      for (var y = 0; y < listItems.length; y++) {
        final listProductos = await productosApi.productoDatabase.getProductosByIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
        if (listProductos.length > 0) {
          contador++;
        }
      }

      if (contador > 0) {
        lista.add(listSubCategories[x]);
      }
    }

    return lista;
  }

  Future<List<ItemSubCategoryModel>> getItemSubCategories(String idSubCategory) async {
    final productosApi = BienesApi();
    final List<ItemSubCategoryModel> lista = [];

    final listItems = await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(idSubCategory);
    for (var y = 0; y < listItems.length; y++) {
      final listProductos = await productosApi.productoDatabase.getProductosByIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
      if (listProductos.length > 0) {
        lista.add(listItems[y]);
      }
    }

    return lista;
  }

  Future<List<CategoryModel>> getCategoriesService() async {
    final servicioApi = ServiciosApi();
    await servicioApi.obtenerServiciosPorCiudad();
    final List<CategoryModel> lista = [];

    final listaCategories = await categoryApi.categoryDatabase.getCategories();

    for (var i = 0; i < listaCategories.length; i++) {
      int contador = 0;

      final listSubCategories = await categoryApi.subcategoryDatabase.getSubCategoriesByIdCategory(listaCategories[i].idCategory.toString());

      for (var x = 0; x < listSubCategories.length; x++) {
        final listItems =
            await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(listSubCategories[x].idSubCategory.toString());
        for (var y = 0; y < listItems.length; y++) {
          final listProductos = await servicioApi.servicioDatabase.getServiciosPorIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
          if (listProductos.length > 0) {
            contador++;
          }
        }
      }

      if (contador > 0) {
        lista.add(listaCategories[i]);
      }
    }

    return lista;
  }

  Future<List<SubCategoryModel>> getSubCategoriesService(String idCategory) async {
    final servicioApi = ServiciosApi();
    final List<SubCategoryModel> lista = [];

    final listSubCategories = await categoryApi.subcategoryDatabase.getSubCategoriesByIdCategory(idCategory);

    for (var x = 0; x < listSubCategories.length; x++) {
      int contador = 0;
      final listItems = await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(listSubCategories[x].idSubCategory.toString());
      for (var y = 0; y < listItems.length; y++) {
        final listProductos = await servicioApi.servicioDatabase.getServiciosPorIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
        if (listProductos.length > 0) {
          contador++;
        }
      }

      if (contador > 0) {
        lista.add(listSubCategories[x]);
      }
    }

    return lista;
  }

  Future<List<ItemSubCategoryModel>> getItemSubCategoriesService(String idSubCategory) async {
    final servicioApi = ServiciosApi();
    final List<ItemSubCategoryModel> lista = [];

    final listItems = await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(idSubCategory);
    for (var y = 0; y < listItems.length; y++) {
      final listProductos = await servicioApi.servicioDatabase.getServiciosPorIdItemSubCategoria(listItems[y].idItemSubCategory.toString());
      if (listProductos.length > 0) {
        lista.add(listItems[y]);
      }
    }

    return lista;
  }
}
