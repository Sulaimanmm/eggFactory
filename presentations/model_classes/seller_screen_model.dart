class SellerDetailsModel {
  int statusCode;
  List<SellerInfo> data;
  String message;

  SellerDetailsModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory SellerDetailsModel.fromJson(Map<String, dynamic> json) {
    return SellerDetailsModel(
      statusCode: json['statusCode'],
      data: List<SellerInfo>.from(
          json['data'].map((x) => SellerInfo.fromJson(x))),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'message': message,
    };
  }
}

class SellerInfo {
  String name;
  String dealerId;
  String vehicleNo;
  String password;
  String vehicleId;
  bool isActive;
  int phone;
  DateTime createdAt;
  DateTime updatedAt;

  SellerInfo({
    required this.name,
    required this.dealerId,
    required this.vehicleNo,
    required this.password,
    required this.vehicleId,
    required this.isActive,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SellerInfo.fromJson(Map<String, dynamic> json) {
    return SellerInfo(
      name: json['name'],
      dealerId: json['dealer_id'],
      vehicleNo: json['vehicle_no'],
      password: json['password'],
      vehicleId: json['vehicle_id'],
      isActive: json['is_active'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dealer_id': dealerId,
      'vehicle_no': vehicleNo,
      'password': password,
      'vehicle_id': vehicleId,
      'is_active': isActive,
      'phone': phone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
