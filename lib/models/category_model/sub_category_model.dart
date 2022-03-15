class SubCategoryModel {
  int? status;
  String? message;
  List<SubCategoryData>? data;


  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubCategoryData>[];
      json['data'].forEach((v) {
        data!.add( SubCategoryData.fromJson(v));
      });
    }
  }


}

class SubCategoryData {
  int? id;
  String? name;
  String? icon;


  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }


}
