class ExtractionModel{
  bool? status;
  dynamic?message;
  ExtractionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}