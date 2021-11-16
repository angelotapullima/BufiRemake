import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/itemSubCategoriesEntities.dart';

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

  factory ItemSubCategoriesModel.fromJson(Map<dynamic, String> json) => ItemSubCategoriesModel(
        idItemSubCategory: json["idItemSubCategory"],
        nameItemSubCategory: json["nameItemSubCategory"],
        imagenItemSubCategory: json["imagenItemSubCategory"],
        estadoItemSubCategory: json["estadoItemSubCategory"],
        idSubCategory: json["idSubCategory"],
      );
}