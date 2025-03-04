class SaleModel {
  int? statusCode;
  List<Data>? data;
  String? message;

  SaleModel({this.statusCode, this.data, this.message});

  SaleModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? saleId;
  String? vehicleId;
  String? shopId;
  int? totalAmount;
  int? amountPaid;
  int? credit;
  String? saleDate;
  CrateData? crateData;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.saleId,
      this.vehicleId,
      this.shopId,
      this.totalAmount,
      this.amountPaid,
      this.credit,
      this.saleDate,
      this.crateData,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    vehicleId = json['vehicle_id'];
    shopId = json['shop_id'];
    totalAmount = json['total_amount'];
    amountPaid = json['amount_paid'];
    credit = json['credit'];
    saleDate = json['sale_date'];
    crateData = json['crate_data'] != null
        ? new CrateData.fromJson(json['crate_data'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['vehicle_id'] = this.vehicleId;
    data['shop_id'] = this.shopId;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['credit'] = this.credit;
    data['sale_date'] = this.saleDate;
    if (this.crateData != null) {
      data['crate_data'] = this.crateData!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CrateData {
  int? redTray;
  int? blueTray;
  int? trayPrice;
  int? pendingRedTray;
  int? pendingBlueTray;
  int? previousRedTray;
  int? previousBlueTray;

  CrateData(
      {this.redTray,
      this.blueTray,
      this.trayPrice,
      this.pendingRedTray,
      this.pendingBlueTray,
      this.previousRedTray,
      this.previousBlueTray});

  CrateData.fromJson(Map<String, dynamic> json) {
    redTray = json['red_tray'];
    blueTray = json['blue_tray'];
    trayPrice = json['tray_price'];
    pendingRedTray = json['pending_red_tray'];
    pendingBlueTray = json['pending_blue_tray'];
    previousRedTray = json['previous_red_tray'];
    previousBlueTray = json['previous_blue_tray'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['red_tray'] = this.redTray;
    data['blue_tray'] = this.blueTray;
    data['tray_price'] = this.trayPrice;
    data['pending_red_tray'] = this.pendingRedTray;
    data['pending_blue_tray'] = this.pendingBlueTray;
    data['previous_red_tray'] = this.previousRedTray;
    data['previous_blue_tray'] = this.previousBlueTray;
    return data;
  }
}
