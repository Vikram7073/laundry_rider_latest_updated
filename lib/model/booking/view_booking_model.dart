class ViewBookingModel {
  bool? success;
  Data? data;

  ViewBookingModel({this.success, this.data});

  ViewBookingModel.fromJson(Map<String, dynamic> json) {
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
  List<ItemList>? itemList;
  int? bookId;
  String? deliverOn;
  String? orderId;
  String? orderDate;
  int? totalProduct;
  int? invoiceAmount;
  int? discount;
  int? netAmount;
  String? address;

  Data(
      {this.itemList,
        this.bookId,
        this.deliverOn,
        this.orderId,
        this.orderDate,
        this.totalProduct,
        this.invoiceAmount,
        this.discount,
        this.netAmount,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList!.add(new ItemList.fromJson(v));
      });
    }
    bookId = json['bookId'];
    deliverOn = json['deliverOn'];
    orderId = json['orderId'];
    orderDate = json['orderDate'];
    totalProduct = json['totalProduct'];
    invoiceAmount = json['invoiceAmount'];
    discount = json['discount'];
    netAmount = json['netAmount'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['itemList'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    data['bookId'] = this.bookId;
    data['deliverOn'] = this.deliverOn;
    data['orderId'] = this.orderId;
    data['orderDate'] = this.orderDate;
    data['totalProduct'] = this.totalProduct;
    data['invoiceAmount'] = this.invoiceAmount;
    data['discount'] = this.discount;
    data['netAmount'] = this.netAmount;
    data['address'] = this.address;
    return data;
  }
}

class ItemList {
  int? itemId;
  String? productName;
  int? qty;
  int? price;
  bool ? isAdded = false;

  ItemList({this.itemId, this.productName,  this.qty, this.price,this.isAdded});

  ItemList.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    productName = json['productName'];
    qty = json['qty'];
    price = json['price'];
    isAdded = json['isAdded'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['productName'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['isAdded'] = this.isAdded;

    return data;
  }
}
