


import 'package:bufi_remake/features/domain/entities/Explorer/itemSubCategoriesEntities.dart';

class ItemSubCategoriesModel extends ItemSubCateriesEntities {
  ItemSubCategoriesModel({
    required String? idItemSubCategory,
    required String? nameItemSubCategory,
    required String? imagenItemSubCategory,
    required String? estadoItemSubCategory,
    required String? idSubCategory,
  }) : super(
          idItemSubCategory: idItemSubCategory,
          nameItemSubCategory: nameItemSubCategory,
          imagenItemSubCategory: imagenItemSubCategory,
          estadoItemSubCategory: estadoItemSubCategory,
          idSubCategory: idSubCategory,
        );

  static List<ItemSubCategoriesModel> fromJsonList(List<dynamic> json) => json.map((i) => ItemSubCategoriesModel.fromJson(i)).toList();

  factory ItemSubCategoriesModel.fromJson(Map<dynamic, dynamic> json) => ItemSubCategoriesModel(
        idItemSubCategory: json["idItemSubCategory"],
        nameItemSubCategory: json["nameItemSubCategory"],
        imagenItemSubCategory: json["imagenItemSubCategory"],
        estadoItemSubCategory: json["estadoItemSubCategory"],
        idSubCategory: json["idSubCategory"],
      );
}
