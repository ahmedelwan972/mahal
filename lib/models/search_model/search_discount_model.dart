class SearchDiscountModel {
  int? status;
  String? message;
  List<SearchDiscountData>? data;

  SearchDiscountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchDiscountData>[];
      json['data'].forEach((v) {
        data!.add( SearchDiscountData.fromJson(v));
      });
    }
  }

}

class SearchDiscountData {
  String? discountName;
  int? id;
  String? description;
  String? nameEn;
  String? nameAr;
  String? startDate;
  String? endDate;
  int? companyId;
  String? descriptionEn;
  String? descriptionAr;
  int? visitorDiscount;
  String? type;
  String? image;
  String? workStatus;
  Null? endDateAmount;
  int? views;
  int? priority;
  int? status;
  int? deleteStatus;
  String? createdAt;
  String? updatedAt;
  double? distance;
  String? categoryName;



  SearchDiscountData.fromJson(Map<String, dynamic> json) {
    discountName = json['discountName'];
    id = json['id'];
    description = json['description'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    companyId = json['company_id'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    visitorDiscount = json['visitor_discount'];
    type = json['type'];
    image = json['image'];
    workStatus = json['work_status'];
    endDateAmount = json['endDate_amount'];
    views = json['views'];
    priority = json['priority'];
    status = json['status'];
    deleteStatus = json['delete_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distance = json['distance'];
    categoryName = json['categoryName'];
  }


}
