class CategoryModel {
  int? status;
  String? message;
  List<Data> data =[];


  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? id;
  String? name;
  String? icon;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

}
