class SearchCompanyModel {
  int? status;
  String? message;
  List<SearchCompanyData>? data;


  SearchCompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchCompanyData>[];
      json['data'].forEach((v) {
        data!.add(SearchCompanyData.fromJson(v));
      });
    }
  }

}

class SearchCompanyData {
  int? id;
  String? companyName;
  String? address;
  String? description;
  String? companyLogo;
  String? cityName;
  String? categoryName;
  String? iconImage;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? addressEn;
  String? addressAr;
  int? workStatus;
  String? startTime;
  String? endTime;
  Null? image;
  int? rate;
  int? visitorNumber;
  int? memberId;
  String? lat;
  String? lang;
  int? status;
  int? order;
  int? featured;
  String? slug;
  Null? companyStatus;
  int? views;
  int? priority;
  int? deleteStatus;
  String? createdAt;
  String? updatedAt;



  SearchCompanyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    address = json['Address'];
    description = json['Description'];
    companyLogo = json['company_logo'];
    cityName = json['cityName'];
    categoryName = json['categoryName'];
    iconImage = json['iconImage'];
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
  }

}
