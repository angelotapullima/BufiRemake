class BienesModel {
  String? idGood;
  String? goodName;
  String? goodSynonyms;

  BienesModel({
    this.idGood,
    this.goodName,
    this.goodSynonyms,
  });
  static List<BienesModel> fromJsonList(List<dynamic> json) => json.map((i) => BienesModel.fromJson(i)).toList();

  factory BienesModel.fromJson(Map<String, dynamic> json) => BienesModel(
        idGood: json["idGood"],
        goodName: json["goodName"],
        goodSynonyms: json["goodSynonyms"],
      );
}
