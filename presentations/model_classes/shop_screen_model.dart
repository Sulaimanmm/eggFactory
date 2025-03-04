class ShopDetailsModel {
  int? statusCode;
  List<ShopData>? data;
  String? message;

  ShopDetailsModel({this.statusCode, this.data, this.message});

  ShopDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ShopData>[];
      json['data'].forEach((v) {
        data!.add(new ShopData.fromJson(v));
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

class ShopData {
  String? name;
  String? shopId;
  String? vehicleId;
  String? dealerId;
  String? address;
  String? locationId;
  bool? isActive;
  int? credit;
  int? phone;
  CrateData? crateData;
  String? createdAt;
  String? updatedAt;
  Location? location;
  Vehicle? vehicle;

  ShopData(
      {this.name,
      this.shopId,
      this.vehicleId,
      this.dealerId,
      this.address,
      this.locationId,
      this.isActive,
      this.credit,
      this.phone,
      this.crateData,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.vehicle});

  ShopData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shopId = json['shop_id'];
    vehicleId = json['vehicle_id'];
    dealerId = json['dealer_id'];
    address = json['address'];
    locationId = json['location_id'];
    isActive = json['is_active'];
    credit = json['credit'];
    phone = json['phone'];
    crateData = json['crate_data'] != null
        ? new CrateData.fromJson(json['crate_data'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shop_id'] = this.shopId;
    data['vehicle_id'] = this.vehicleId;
    data['dealer_id'] = this.dealerId;
    data['address'] = this.address;
    data['location_id'] = this.locationId;
    data['is_active'] = this.isActive;
    data['credit'] = this.credit;
    data['phone'] = this.phone;
    if (this.crateData != null) {
      data['crate_data'] = this.crateData!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    return data;
  }
}

class CrateData {
  String? trayBalance;

  CrateData({this.trayBalance});

  CrateData.fromJson(Map<String, dynamic> json) {
    trayBalance = json['tray_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tray_balance'] = this.trayBalance;
    return data;
  }
}

class Location {
  String? locationId;
  String? name;
  String? dealerId;
  String? vehicleId;
  bool? isActive;
  int? zipcode;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.locationId,
      this.name,
      this.dealerId,
      this.vehicleId,
      this.isActive,
      this.zipcode,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    name = json['name'];
    dealerId = json['dealer_id'];
    vehicleId = json['vehicle_id'];
    isActive = json['is_active'];
    zipcode = json['zipcode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['name'] = this.name;
    data['dealer_id'] = this.dealerId;
    data['vehicle_id'] = this.vehicleId;
    data['is_active'] = this.isActive;
    data['zipcode'] = this.zipcode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Vehicle {
  String? name;
  String? dealerId;
  String? vehicleNo;
  String? password;
  String? vehicleId;
  bool? isActive;
  int? phone;
  String? createdAt;
  String? updatedAt;

  Vehicle(
      {this.name,
      this.dealerId,
      this.vehicleNo,
      this.password,
      this.vehicleId,
      this.isActive,
      this.phone,
      this.createdAt,
      this.updatedAt});

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dealerId = json['dealer_id'];
    vehicleNo = json['vehicle_no'];
    password = json['password'];
    vehicleId = json['vehicle_id'];
    isActive = json['is_active'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dealer_id'] = this.dealerId;
    data['vehicle_no'] = this.vehicleNo;
    data['password'] = this.password;
    data['vehicle_id'] = this.vehicleId;
    data['is_active'] = this.isActive;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
