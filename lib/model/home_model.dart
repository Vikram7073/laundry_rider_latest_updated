class HomeModel {
  bool? success;
  Data? data;

  HomeModel({this.success, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  List<BookingList>? bookingList;

  Data({this.name, this.bookingList});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['bookingList'] != null) {
      bookingList = <BookingList>[];
      json['bookingList'].forEach((v) {
        bookingList!.add(new BookingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.bookingList != null) {
      data['bookingList'] = this.bookingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingList {
  String? image;
  String? listName;
  String? colorCode;
  int? totalBooking;

  BookingList({this.image, this.listName, this.colorCode, this.totalBooking});

  BookingList.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    listName = json['listName'];
    colorCode = json['colorCode'];
    totalBooking = json['totalBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['listName'] = this.listName;
    data['colorCode'] = this.colorCode;
    data['totalBooking'] = this.totalBooking;
    return data;
  }
}
