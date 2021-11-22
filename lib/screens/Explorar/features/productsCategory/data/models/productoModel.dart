import 'package:bufi_remake/screens/Explorar/features/productsCategory/domain/entities/categoriesEntities.dart';

class ProductoModel extends CategoriesEntities {
  ProductoModel({
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

  static List<ProductoModel> fromJsonList(List<dynamic> json) => json.map((i) => ProductoModel.fromJson(i)).toList();

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idCategory: json["idCategory"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
        categoryEstado: json["categoryEstado"],
      );
}
