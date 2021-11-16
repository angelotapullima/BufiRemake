import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/subCategoriesEntities.dart';

class DataGeneralEntities {
  List<CategoriesEntities> listCategories;
  List<SubCategoriesEntities> listSubCategories;
  List<ItemSubCateriesEntities> listItemSubCategories;

  DataGeneralEntities({
    required this.listCategories,
    required this.listSubCategories,
    required this.listItemSubCategories,
  });
}