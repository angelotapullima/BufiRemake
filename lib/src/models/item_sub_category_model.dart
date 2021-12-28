class ItemSubCategoryModel {
  String? idItemSubCategory;
  String? nameItemSubCategory;
  String? estadoItemSubCategory;
  String? imagenItemSubCategory;
  String? idSubCategory;

  ItemSubCategoryModel({
    this.idItemSubCategory,
    this.nameItemSubCategory,
    this.estadoItemSubCategory,
    this.imagenItemSubCategory,
    this.idSubCategory,
  });

  static List<ItemSubCategoryModel> fromJsonList(List<dynamic> json) => json.map((i) => ItemSubCategoryModel.fromJson(i)).toList();

  factory ItemSubCategoryModel.fromJson(Map<String, dynamic> json) => ItemSubCategoryModel(
        idItemSubCategory: json["idItemSubCategory"],
        nameItemSubCategory: json["nameItemSubCategory"],
        estadoItemSubCategory: json["estadoItemSubCategory"],
        imagenItemSubCategory: json["imagenItemSubCategory"],
        idSubCategory: json["idSubCategory"],
      );
}
