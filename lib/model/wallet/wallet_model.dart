class WalletEarningModel {
  bool? success;
  Data? data;

  WalletEarningModel({this.success, this.data});

  WalletEarningModel.fromJson(Map<String, dynamic> json) {
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
  int? currentBalance;
  List<EarnList>? earnList;
  List<WithdrawlList>? withdrawlList;

  Data({this.currentBalance, this.earnList, this.withdrawlList});

  Data.fromJson(Map<String, dynamic> json) {
    currentBalance = json['currentBalance'];
    if (json['earnList'] != null) {
      earnList = <EarnList>[];
      json['earnList'].forEach((v) {
        earnList!.add(new EarnList.fromJson(v));
      });
    }
    if (json['withdrawlList'] != null) {
      withdrawlList = <WithdrawlList>[];
      json['withdrawlList'].forEach((v) {
        withdrawlList!.add(new WithdrawlList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentBalance'] = this.currentBalance;
    if (this.earnList != null) {
      data['earnList'] = this.earnList!.map((v) => v.toJson()).toList();
    }
    if (this.withdrawlList != null) {
      data['withdrawlList'] =
          this.withdrawlList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EarnList {
  String? bookId;
  String? pickDate;
  int? amount;

  EarnList({this.bookId, this.pickDate, this.amount});

  EarnList.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    pickDate = json['pickDate'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['pickDate'] = this.pickDate;
    data['amount'] = this.amount;
    return data;
  }
}

class WithdrawlList {
  int? withdrawlAmount;
  String? status;
  String? date;

  WithdrawlList({this.withdrawlAmount, this.status, this.date});

  WithdrawlList.fromJson(Map<String, dynamic> json) {
    withdrawlAmount = json['withdrawlAmount'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['withdrawlAmount'] = this.withdrawlAmount;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
