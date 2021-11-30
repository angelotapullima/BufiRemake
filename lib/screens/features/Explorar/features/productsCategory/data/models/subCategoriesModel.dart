import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/entities/subCategoriesEntities.dart';

class SubCategoriesModel extends SubCategoriesEntities {
  SubCategoriesModel({
    required String? idSubCategory,
    required String? nameSubCategory,
    required String? idCategory,
  }) : super(
          idSubCategory: idSubCategory,
          subCategoryName: nameSubCategory,
          idCategory: idCategory,
        );

  static List<SubCategoriesModel> fromJsonList(List<dynamic> json) => json.map((i) => SubCategoriesModel.fromJson(i)).toList();

  factory SubCategoriesModel.fromJson(Map<dynamic, dynamic> json) => SubCategoriesModel(
        idSubCategory: json["idSubCategory"],
        nameSubCategory: json["nameSubCategory"],
        idCategory: json["idCategory"],
      );
}
 