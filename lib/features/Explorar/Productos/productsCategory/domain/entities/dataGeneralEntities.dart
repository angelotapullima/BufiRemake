
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/categoriesEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/entities/subCategoriesEntities.dart';

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
