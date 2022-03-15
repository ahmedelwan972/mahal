class CatListModel {
  int? status;
  String? message;
  List<CatListData>? data;


  CatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CatListData>[];
      json['data'].forEach((v) {
        data!.add( CatListData.fromJson(v));
      });
    }
  }


}

class CatListData {
  int? id;
  String? name;


  CatListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
