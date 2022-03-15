class AddFavModel{

  int? status;
  String? message;

  AddFavModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }
}