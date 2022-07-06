class UserInformation {
  bool? status;
  Data? data;
  String? email_verified_at;

  UserInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    email_verified_at = json['email_verified_at'];
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? ssn;
  String? phone;
  String? sex;
  String? unionNumber;
  int? unionId;
  int? roleId;

  Data(
      {this.id,
      this.name,
      this.email,
      this.ssn,
      this.phone,
      this.sex,
      this.unionNumber,
      this.unionId,
      this.roleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ssn = json['ssn'];
    phone = json['phone'];
    sex = json['sex'];
    unionNumber = json['union_number'];
    unionId = json['union_id'];
    roleId = json['role_id'];
  }
}
