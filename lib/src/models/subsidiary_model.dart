class SubsidiaryModel {
  String? idSubsidiary;
  String? idCompany;
  String? subsidiaryName;
  String? subsidiaryDescription;
  String? subsidiaryAddress;
  String? subsidiaryImg;
  String? subsidiaryCellphone;
  String? subsidiaryCellphone2;
  String? subsidiaryEmail;
  String? subsidiaryCoordX;
  String? subsidiaryCoordY;
  String? subsidiaryOpeningHours;
  String? subsidiaryPrincipal;
  String? subsidiaryStatus;
  String? subsidiaryFavourite;

  SubsidiaryModel({
    this.idSubsidiary,
    this.idCompany,
    this.subsidiaryName,
    this.subsidiaryDescription,
    this.subsidiaryAddress,
    this.subsidiaryImg,
    this.subsidiaryCellphone,
    this.subsidiaryCellphone2,
    this.subsidiaryEmail,
    this.subsidiaryCoordX,
    this.subsidiaryCoordY,
    this.subsidiaryOpeningHours,
    this.subsidiaryPrincipal,
    this.subsidiaryStatus,
    this.subsidiaryFavourite,
  });

  static List<SubsidiaryModel> fromJsonList(List<dynamic> json) => json.map((i) => SubsidiaryModel.fromJson(i)).toList();

  factory SubsidiaryModel.fromJson(Map<String, dynamic> json) => SubsidiaryModel(
        idSubsidiary: json["idSubsidiary"],
        idCompany: json["idCompany"],
        subsidiaryName: json["subsidiaryName"],
        subsidiaryDescription: json["subsidiaryDescription"],
        subsidiaryAddress: json["subsidiaryAddress"],
        subsidiaryImg: json["subsidiaryImg"],
        subsidiaryCellphone: json["subsidiaryCellphone"],
        subsidiaryCellphone2: json["subsidiaryCellphone2"],
        subsidiaryEmail: json["subsidiaryEmail"],
        subsidiaryCoordX: json["subsidiaryCoordX"],
        subsidiaryCoordY: json["subsidiaryCoordY"],
        subsidiaryOpeningHours: json["subsidiaryOpeningHours"],
        subsidiaryPrincipal: json["subsidiaryPrincipal"],
        subsidiaryStatus: json["subsidiaryStatus"],
        subsidiaryFavourite: json["subsidiaryFavourite"],
      );
}
