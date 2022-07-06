class UserModel {
  bool? status;
  dynamic message;
  Data? data;
  String? token;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
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
