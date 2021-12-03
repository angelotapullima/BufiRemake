



import 'package:bufi_remake/features/domain/entities/Explorar/categoriesEntities.dart';

class CategoriesModel extends CategoriesEntities {

  CategoriesModel({
    required String? idCategory,
    required String? categoryName,
    required String? categoryImage,
    required String? categoryEstado,
  }) : super(
          idCategory: idCategory,
          categoryName: categoryName,
          categoryImage: categoryImage,
          categoryEstado: categoryEstado,
        );

  static List<CategoriesModel> fromJsonList(List<dynamic> json) => json.map((i) => CategoriesModel.fromJson(i)).toList();

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        idCategory: json["idCategory"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
        categoryEstado: json["categoryEstado"],
      );
}
