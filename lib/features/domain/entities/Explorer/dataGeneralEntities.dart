

import 'package:bufi_remake/features/domain/entities/Explorer/categoriesEntities.dart';
import 'package:bufi_remake/features/domain/entities/Explorer/itemSubCategoriesEntities.dart';
import 'package:bufi_remake/features/domain/entities/Explorer/subCategoriesEntities.dart';

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
