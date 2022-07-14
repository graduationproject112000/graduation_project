class UnionsPhone {
  bool? status;
  DataPhone? data;

  UnionsPhone({this.status, this.data});

  UnionsPhone.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataPhone.fromJson(json['data']) : null;
  }
}

class DataPhone {
  String? phone;

  DataPhone({this.phone});

  DataPhone.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }
}
