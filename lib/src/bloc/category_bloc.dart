import 'package:bufi_remake/src/api/category_api.dart';
import 'package:bufi_remake/src/models/category_model.dart';
import 'package:bufi_remake/src/models/item_sub_category_model.dart';
import 'package:bufi_remake/src/models/sub_category_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final categoryApi = CategoryApi();
  final _categoryController = BehaviorSubject<List<CategoryModel>>();
  final _subCategoryController = BehaviorSubject<List<SubCategoryModel>>();
  final _itemsubcategoryController = BehaviorSubject<List<ItemSubCategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream => _categoryController.stream;
  Stream<List<SubCategoryModel>> get subcategoryStream => _subCategoryController.stream;
  Stream<List<ItemSubCategoryModel>> get itemsubcategoryStream => _itemsubcategoryController.stream;

  dispose() {
    _categoryController.close();
    _subCategoryController.close();
    _itemsubcategoryController.close();
  }

  void obtenerCategories() async {
    _categoryController.sink.add(await categoryApi.categoryDatabase.getCategories());
    await categoryApi.obtenerCatory();
    _categoryController.sink.add(await categoryApi.categoryDatabase.getCategories());
  }

  void obtenerSubcatgories(String idCategory) async {
    _subCategoryController.sink.add(await categoryApi.subcategoryDatabase.getSubCategoriesByIdCategory(idCategory));
  }

  void obtenerItemsubcategories(String idSubcategory) async {
    _itemsubcategoryController.sink.add(await categoryApi.itemsubcategoryDatabase.getItemSubCategoriesByIdSubCategory(idSubcategory));
  }

  void cleanStreamSubCategory() {
    _subCategoryController.sink.add([]);
  }

  void cleanStreamItemSubCategory() {
    _itemsubcategoryController.sink.add([]);
  }
}
