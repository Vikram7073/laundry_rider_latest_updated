class AcceptBookingModel {
  bool? success;
  String? message;

  AcceptBookingModel({this.success, this.message});

  AcceptBookingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
