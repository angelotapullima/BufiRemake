class SubCategoryModel {
  String? idSubCategory;
  String? nameSubCategory;
  String? idCategory;

  SubCategoryModel({
    this.idSubCategory,
    this.nameSubCategory,
    this.idCategory,
  });
  static List<SubCategoryModel> fromJsonList(List<dynamic> json) => json.map((i) => SubCategoryModel.fromJson(i)).toList();

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        idSubCategory: json["idSubCategory"],
        nameSubCategory: json["nameSubCategory"],
        idCategory: json["idCategory"],
      );
}
