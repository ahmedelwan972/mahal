class SignUpModel {
  int? status;
  String? message;



  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

}





