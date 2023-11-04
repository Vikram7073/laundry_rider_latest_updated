class GetProfileModel {
  bool? success;
  Data? data;

  GetProfileModel({this.success, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? riderId;
  String? firstName;
  String? lastName;
  String? email;
  int? mobileNo;
  String? currentLocation;
  String? city;
  String? permanentLocation;
  String? profileImage;
  String? supportEmail;

  Data(
      {this.riderId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNo,
        this.currentLocation,
        this.city,
        this.permanentLocation,
        this.profileImage,
        this.supportEmail});

  Data.fromJson(Map<String, dynamic> json) {
    riderId = json['riderId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    currentLocation = json['currentLocation'];
    city = json['city'];
    permanentLocation = json['permanentLocation'];
    profileImage = json['profileImage'];
    supportEmail = json['supportEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['riderId'] = this.riderId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['currentLocation'] = this.currentLocation;
    data['city'] = this.city;
    data['permanentLocation'] = this.permanentLocation;
    data['profileImage'] = this.profileImage;
    data['supportEmail'] = this.supportEmail;
    return data;
  }
}
