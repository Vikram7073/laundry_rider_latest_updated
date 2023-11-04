class BookingPageModel {
  BookingPageModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  BookingPageModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.pending,
    required this.accept,
    required this.ongoing,
    required this.pickup,
    required this.deliver,
    required this.cancel,
  });
  late final List<Pending> pending;
  late final List<Accept> accept;
  late final List<Ongoing> ongoing;
  late final List<Pickup> pickup;
  late final List<Deliver> deliver;
  late final List<Cancel> cancel;

  Data.fromJson(Map<String, dynamic> json){
    pending = List.from(json['pending']).map((e)=>Pending.fromJson(e)).toList();
    accept = List.from(json['accept']).map((e)=>Accept.fromJson(e)).toList();
    ongoing = List.from(json['ongoing']).map((e)=>Ongoing.fromJson(e)).toList();
    pickup = List.from(json['pickup']).map((e)=>Pickup.fromJson(e)).toList();
    deliver = List.from(json['deliver']).map((e)=>Deliver.fromJson(e)).toList();
    cancel = List.from(json['cancel']).map((e)=>Cancel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pending'] = pending.map((e)=>e.toJson()).toList();
    _data['accept'] = accept.map((e)=>e.toJson()).toList();
    _data['ongoing'] = ongoing.map((e)=>e.toJson()).toList();
    _data['pickup'] = pickup.map((e)=>e.toJson()).toList();
    _data['deliver'] = deliver.map((e)=>e.toJson()).toList();
    _data['cancel'] = cancel.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pending {
  Pending({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
    required this.late,
    required this.long,
    required this.token,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;
  late final String late;
  late final String long;
  late final String token;

  Pending.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
    late = json['late'];
    long = json['long'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    _data['late'] = late;
    _data['long'] = long;
    _data['token'] = token;
    return _data;
  }
}

class Accept {
  Accept({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
    required this.late,
    required this.long,
    required this.token,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;
  late final String late;
  late final String long;
  late final String token;

  Accept.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
    late = json['late'];
    long = json['long'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    _data['late'] = late;
    _data['long'] = long;
    _data['token'] = token;
    return _data;
  }
}

class Ongoing {
  Ongoing({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
    required this.contact,
    required this.late,
    required this.long,
    required this.token,
    required this.pickUpStatus,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;
  late final int contact;
  late final String late;
  late final String long;
  late final String token;
  late final bool pickUpStatus;

  Ongoing.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
    contact = json['contact'];
    late = json['late'];
    long = json['long'];
    token = json['token'];
    pickUpStatus = json['pickUpStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    _data['contact'] = contact;
    _data['late'] = late;
    _data['long'] = long;
    _data['token'] = token;
    _data['pickUpStatus'] = pickUpStatus;
    return _data;
  }
}

class Pickup {
  Pickup({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
    required this.late,
    required this.long,
    required this.token,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;
  late final String late;
  late final String long;
  late final String token;

  Pickup.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
    late = json['late'];
    long = json['long'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    _data['late'] = late;
    _data['long'] = long;
    _data['token'] = token;
    return _data;
  }
}

class Deliver {
  Deliver({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;

  Deliver.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    return _data;
  }
}

class Cancel {
  Cancel({
    required this.bookId,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.address,
    required this.deliverTime,
  });
  late final int bookId;
  late final String bookingId;
  late final String date;
  late final String time;
  late final String address;
  late final String deliverTime;

  Cancel.fromJson(Map<String, dynamic> json){
    bookId = json['bookId'];
    bookingId = json['bookingId'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    deliverTime = json['deliverTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bookId'] = bookId;
    _data['bookingId'] = bookingId;
    _data['date'] = date;
    _data['time'] = time;
    _data['address'] = address;
    _data['deliverTime'] = deliverTime;
    return _data;
  }
}