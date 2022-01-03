class ServicioModel {
  String? idServicio;
  String? idSubsidiary;
  String? idService;
  String? idItemsubcategory;
  String? servicioName;
  String? servicioDescription;
  String? servicioPrice;
  String? servicioCurrency;
  String? servicioImage;
  String? servicioRating;
  String? servicioUpdated;
  String? servicioStatus;
  String? servicioFavourite;

  ServicioModel({
    this.idServicio,
    this.idSubsidiary,
    this.idService,
    this.idItemsubcategory,
    this.servicioName,
    this.servicioDescription,
    this.servicioPrice,
    this.servicioCurrency,
    this.servicioImage,
    this.servicioRating,
    this.servicioUpdated,
    this.servicioStatus,
    this.servicioFavourite,
  });

  static List<ServicioModel> fromJsonList(List<dynamic> json) => json.map((i) => ServicioModel.fromJson(i)).toList();

  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        idServicio: json["idServicio"],
        idSubsidiary: json["idSubsidiary"],
        idService: json["idService"],
        idItemsubcategory: json["idItemsubcategory"],
        servicioName: json["servicioName"],
        servicioDescription: json["servicioDescription"],
        servicioPrice: json["servicioPrice"],
        servicioCurrency: json["servicioCurrency"],
        servicioImage: json["servicioImage"],
        servicioRating: json["servicioRating"],
        servicioUpdated: json["servicioUpdated"],
        servicioStatus: json["servicioStatus"],
        servicioFavourite: json["servicioFavourite"],
      );
}
