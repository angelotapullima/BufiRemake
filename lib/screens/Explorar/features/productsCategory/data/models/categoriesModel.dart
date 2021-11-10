import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';

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

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        idCategory: json["idCategory"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
        categoryEstado: json["hair_color"],
      );
}
