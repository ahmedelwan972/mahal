class AddDiscountModel{
  int? status;
  String? message;
  AddDiscountModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}