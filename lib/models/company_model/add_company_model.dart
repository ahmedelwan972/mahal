class AddCompanyModel {
  int? status;
  String? message;


  AddCompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}

