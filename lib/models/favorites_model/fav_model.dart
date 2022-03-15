class GetFavModel {
  int? status;
  String? message;
  List<FavData>? data;


  GetFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data!.add( FavData.fromJson(v));
      });
    }
  }


}

class FavData {
  String? accentName;
  int? companyId;
  String? companyName;
  String? companyLogo;
  String? companyDescription;

  FavData(
      {this.accentName,
        this.companyId,
        this.companyName,
        this.companyLogo,
        this.companyDescription});

  FavData.fromJson(Map<String, dynamic> json) {
    accentName = json['accentName'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyLogo = json['company_logo'];
    companyDescription = json['companyDescription'];
  }

}
