class MemberCompaniesModel {
  int? status;
  String? message;
  List<MemberCompaniesData>? data;


  MemberCompaniesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MemberCompaniesData>[];
      json['data'].forEach((v) {
        data!.add( MemberCompaniesData.fromJson(v));
      });
    }
  }

}

class MemberCompaniesData {
  int? id;
  String? companyName;
  String? description;
  String? companyLogo;
  String? accentName;



  MemberCompaniesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    description = json['Description'];
    companyLogo = json['company_logo'];
    accentName = json['accentName'];
  }


}
