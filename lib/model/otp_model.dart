class OTPModel {
  bool? success;
  String? message;
  Data? data;

  OTPModel({this.success, this.message, this.data});

  OTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? mobile;
  bool? kycStatus;
  String? token;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.kycStatus,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    kycStatus = json['kycStatus'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['kycStatus'] = this.kycStatus;
    data['token'] = this.token;
    return data;
  }
}
