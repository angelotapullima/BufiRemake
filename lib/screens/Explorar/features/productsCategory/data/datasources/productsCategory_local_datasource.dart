import 'package:bufi_remake/screens/Explorar/features/productsCategory/data/models/categoriesModel.dart';

abstract class ProductCategoryLocalDataSource {
  Future<List<CategoriesModel>> getListOfPeople();

  Future<void> cacheListOfPeople(List<CategoriesModel> personToCache);
}
