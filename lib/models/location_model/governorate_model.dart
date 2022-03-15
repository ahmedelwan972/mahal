class Governorate {
  int? status;
  String? message;
  List<Data>? data;


  Governorate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }


}

class Data {
  int? id;
  String? name;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
