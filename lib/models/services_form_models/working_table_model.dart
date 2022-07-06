class WorkingTableModel {
  bool? status;
  dynamic message;
  WorkingTableModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
