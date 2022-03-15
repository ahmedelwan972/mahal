class MemberDiscountModel {
  int? status;
  String? message;
  List<MemberDiscountData>? data;


  MemberDiscountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MemberDiscountData>[];
      json['data'].forEach((v) {
        data!.add( MemberDiscountData.fromJson(v));
      });
    }
  }

}

class MemberDiscountData {
  int? id;
  String? discountName;
  String? workStatus;
  String? startDate;
  String? endDate;
  String? type;
  String? image;



  MemberDiscountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountName = json['discountName'];
    workStatus = json['work_status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    type = json['type'];
    image = json['image'];
  }


}
