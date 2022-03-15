class CityModel {
  int? status;
  String? message;
  List<CityData>? data;


  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
      });
    }
  }


}

class CityData {
  int? id;
  String? name;


  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
