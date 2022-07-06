class UserOrder {
  bool? status;
  late List<Data> data = [];
  UserOrder();

  UserOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? nameen;
  String? namear;
  String? title;
  String? img;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameen = json['nameen'];
    namear = json['namear'];
    title = json['title'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? user1Id;
  int? serviceId;
  String? createdAt;
  String? updatedAt;
  String? message;
  String? status;

  Pivot(
      {this.user1Id,
      this.serviceId,
      this.createdAt,
      this.updatedAt,
      this.message,
      this.status});

  Pivot.fromJson(Map<String, dynamic> json) {
    user1Id = json['user1_id'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    message = json['message'];
    status = json['status'];
  }
}
