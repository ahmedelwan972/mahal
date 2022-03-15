class CompanyCategoryModel {
  int? status;
  String? message;
  List<CompanyCategorySubData>? data;


  CompanyCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompanyCategorySubData>[];
      json['data'].forEach((v) {
        data!.add( CompanyCategorySubData.fromJson(v));
      });
    }
  }


}

class CompanyCategorySubData {
  dynamic id;
  String? companyName;
  String? description;
  String? companyLogo;
  String? accentName;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? addressEn;
  String? addressAr;
  int? workStatus;
  String? startTime;
  String? endTime;
  String? image;
  int? rate;
  int? visitorNumber;
  int? memberId;
  String? lat;
  String? lang;
  int? status;
  String? order;
  int? featured;
  String? slug;
  String? companyStatus;
  int? views;
  int? priority;
  int? deleteStatus;
  String? createdAt;
  String? updatedAt;
  double? distance;
  int? isFav;



  CompanyCategorySubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    description = json['description'];
    companyLogo = json['company_logo'];
    accentName = json['accentName'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    addressEn = json['address_en'];
    addressAr = json['address_ar'];
    workStatus = json['work_status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    image = json['image'];
    rate = json['rate'];
    visitorNumber = json['visitor_number'];
    memberId = json['member_id'];
    lat = json['lat'];
    lang = json['lang'];
    status = json['status'];
    order = json['order'];
    featured = json['featured'];
    slug = json['slug'];
    companyStatus = json['company_status'];
    views = json['views'];
    priority = json['priority'];
    deleteStatus = json['delete_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distance = json['distance'];
    isFav = json['is_fav'];
  }


}
