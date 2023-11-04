class BankDetailAddModel {
  bool? status;
  Data? data;
  String? message;

  BankDetailAddModel({this.status, this.data, this.message});

  BankDetailAddModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? token;
  bool? kycStatus;

  Data({this.token, this.kycStatus});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    kycStatus = json['kycStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['kycStatus'] = this.kycStatus;
    return data;
  }
}
