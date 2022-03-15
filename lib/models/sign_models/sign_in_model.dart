class SignInModel {
  int? status;
  String? message;
  SignInData? data;


  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  SignInData.fromJson(json['data']) : null;
  }


}

class SignInData {
  int? id;
  String? nameEn;
  String? image;
  String? mobile;
  String? email;
  String? password;
  Null? confirm;
  String? role;
  String? updatedAt;
  String? createdAt;
  Null? facebookId;
  Null? twitterId;
  Null? googlePlusId;
  Null? facebookTocken;
  Null? twitterTocken;
  Null? googlePlusTocken;
  String? fmcToken;



  SignInData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    image = json['image'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    confirm = json['confirm'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    facebookId = json['facebook_id'];
    twitterId = json['twitter_id'];
    googlePlusId = json['googlePlus_id'];
    facebookTocken = json['facebook_tocken'];
    twitterTocken = json['twitter_tocken'];
    googlePlusTocken = json['googlePlus_tocken'];
    fmcToken = json['fmc_token'];
  }


}
