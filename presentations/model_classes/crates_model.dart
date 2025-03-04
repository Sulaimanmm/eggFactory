class CrateModel {
  int? statusCode;
  List<Data>? data;
  String? message;

  CrateModel({this.statusCode, this.data, this.message});

  CrateModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? crateId;
  String? type;
  String? dealerId;
  bool? isActive;
  int? capacity;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.name,
      this.crateId,
      this.type,
      this.dealerId,
      this.isActive,
      this.capacity,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    crateId = json['crate_id'];
    type = json['type'];
    dealerId = json['dealer_id'];
    isActive = json['is_active'];
    capacity = json['capacity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['crate_id'] = this.crateId;
    data['type'] = this.type;
    data['dealer_id'] = this.dealerId;
    data['is_active'] = this.isActive;
    data['capacity'] = this.capacity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
