class AreaDetailsModel {
  int? statusCode;
  List<AreaInfo>? data;
  String? message;

  AreaDetailsModel({this.statusCode, this.data, this.message});

  AreaDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <AreaInfo>[];
      json['data'].forEach((v) {
        data!.add(new AreaInfo.fromJson(v));
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

class AreaInfo {
  String? locationId;
  String? name;
  String? dealerId;
  String? vehicleId;
  bool? isActive;
  int? zipcode;
  String? createdAt;
  String? updatedAt;

  AreaInfo(
      {this.locationId,
      this.name,
      this.dealerId,
      this.vehicleId,
      this.isActive,
      this.zipcode,
      this.createdAt,
      this.updatedAt});

  AreaInfo.fromJson(Map<String, dynamic> json) {
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
