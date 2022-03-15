class ContactModel{
  int? status;
  String? message;
  ContactModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}