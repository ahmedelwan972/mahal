class CompanyShowModel {
  int? status;
  String? message;
  CompanyShowData? data;


  CompanyShowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  CompanyShowData.fromJson(json['data']) : null;
  }


}

class CompanyShowData {
  int? id;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? addressEn;
  String? addressAr;
  int? workStatus;
  String? startTime;
  String? endTime;
  String? companyLogo;
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
  String? memberImage;
  String? memberName;
  String? categoryName;
  String? name;
  String? address;
  String? description;
  List<Services>? services;
  List<Mobiles>? mobiles;
  List<Images>? images;
  List<Days>? days;
  List<Categories>? categories;
  List<City>? city;
  List<Nearby>? nearby;



  CompanyShowData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    addressEn = json['address_en'];
    addressAr = json['address_ar'];
    workStatus = json['work_status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    companyLogo = json['company_logo'];
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
    memberId = json['memberId'];
    memberImage = json['memberImage'];
    memberName = json['memberName'];
    categoryName = json['categoryName'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
    if (json['mobiles'] != null) {
      mobiles = <Mobiles>[];
      json['mobiles'].forEach((v) {
        mobiles!.add( Mobiles.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add( Images.fromJson(v));
      });
    }
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add( Days.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add( Categories.fromJson(v));
      });
    }
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add( City.fromJson(v));
      });
    }
    if (json['nearby'] != null) {
      nearby = <Nearby>[];
      json['nearby'].forEach((v) {
        nearby!.add( Nearby.fromJson(v));
      });
    }
  }

}

class Services {
  String? name;
  int? id;


  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }


}

class Mobiles {
  int? id;
  String? mobile;


  Mobiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
  }


}

class Images {

  int? id;
  String? image;

  Images.fromJson(Map<String,dynamic>json){
    id = json['id'];
    image = json['image'];
  }

}

class Days{
  int? id;

  Days.fromJson(Map<String,dynamic>json){
    id = json['id'];
  }
}

class City{
  int? id;
  String? name;

  City.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
  }
}


class Categories {
  int? id;
  int? sub;
  String? name;
  String? subName;


  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sub = json['sub'];
    name = json['name'];
    subName = json['sub_name'];
  }


}

class Nearby {
  int? id;
  String? companyName;
  String? description;
  String? companyLogo;
  String? accentName;
  dynamic distance;



  Nearby.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    description = json['description'];
    companyLogo = json['company_logo'];
    accentName = json['accentName'];
    distance = json['distance'];
  }




}



