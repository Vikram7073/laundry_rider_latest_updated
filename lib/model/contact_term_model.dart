class ContactTermPrivacyModel {
  bool? success;
  Data? data;

  ContactTermPrivacyModel({this.success, this.data});

  ContactTermPrivacyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? contactEmail;
  String? terms;
  String? policy;

  Data({this.contactEmail, this.terms, this.policy});

  Data.fromJson(Map<String, dynamic> json) {
    contactEmail = json['contactEmail'];
    terms = json['terms'];
    policy = json['policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactEmail'] = this.contactEmail;
    data['terms'] = this.terms;
    data['policy'] = this.policy;
    return data;
  }
}
