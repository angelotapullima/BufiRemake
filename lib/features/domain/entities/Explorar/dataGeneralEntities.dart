

import 'package:bufi_remake/features/domain/entities/Explorar/categoriesEntities.dart';
import 'package:bufi_remake/features/domain/entities/Explorar/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/features/domain/entities/Explorar/subCategoriesEntities.dart';

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
