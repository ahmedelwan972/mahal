class ServiceModel {
  int? status;
  String? message;
  List<ServiceData>? data;


  ServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
      });
    }
  }


}

class ServiceData {
  int? id;
  String? name;


  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
