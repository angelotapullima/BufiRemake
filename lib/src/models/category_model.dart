class CategoryModel {
  String? idCategory;
  String? categoryName;
  String? categoryEstado;
  String? categoryImage;

  CategoryModel({
    this.idCategory,
    this.categoryName,
    this.categoryEstado,
    this.categoryImage,
  });

  static List<CategoryModel> fromJsonList(List<dynamic> json) => json.map((i) => CategoryModel.fromJson(i)).toList();

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        idCategory: json["idCategory"],
        categoryName: json["categoryName"],
        categoryEstado: json["categoryEstado"],
        categoryImage: json["categoryImage"],
      );
}
