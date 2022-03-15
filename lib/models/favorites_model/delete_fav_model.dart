class DeleteFavModel{

  int? status;
  String? message;

  DeleteFavModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }


}