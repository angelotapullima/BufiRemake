import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/subCategoriesEntities.dart';

class SubCategoriesModel extends SubCategoriesEntities {
  SubCategoriesModel({
    required String? idSubCategory,
    required String? nameCategory,
    required String? idCategory,
  }) : super(
          idSubCategory: idSubCategory,
          subCategoryName: nameCategory,
          idCategory: idCategory,
        );

  static List<SubCategoriesModel> fromJsonList(List<dynamic> json) => json.map((i) => SubCategoriesModel.fromJson(i)).toList();

  factory SubCategoriesModel.fromJson(Map<dynamic, String> json) => SubCategoriesModel(
        idSubCategory: json["idSubCategory"],
        nameCategory: json["nameCategory"],
        idCategory: json["idCategory"],
      );
}
