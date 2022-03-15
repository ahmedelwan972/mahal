class CityListModel {
  int? status;
  String? message;
  List<CityListData>? data;


  CityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CityListData>[];
      json['data'].forEach((v) {
        data!.add( CityListData.fromJson(v));
      });
    }
  }


}

class CityListData {
  int? id;
  String? name;


  CityListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
