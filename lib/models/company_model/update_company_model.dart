class UpdateCompanyModel{

  int? status;
  String? message;

  UpdateCompanyModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }

}