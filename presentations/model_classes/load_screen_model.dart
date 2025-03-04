class LoadModel {
  final int statusCode;
  final List<LoadData> data;
  final String message;

  LoadModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  // Factory constructor to create LoadModel from JSON
  factory LoadModel.fromJson(Map<String, dynamic> json) {
    return LoadModel(
      statusCode: json['statusCode'] as int,
      data: (json['data'] as List<dynamic>)
          .map((item) => LoadData.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
    );
  }

  // Method to convert LoadModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.map((item) => item.toJson()).toList(),
      'message': message,
    };
  }
}

class LoadData {
  final String loadId;
  final String type;
  final int singlePrice;
  final int totalCount;
  final int totalAmount;
  final String vehicleId;
  final String loadDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoadData({
    required this.loadId,
    required this.type,
    required this.singlePrice,
    required this.totalCount,
    required this.totalAmount,
    required this.vehicleId,
    required this.loadDate,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create LoadData from JSON
  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
      loadId: json['load_id'] as String,
      type: json['type'] as String,
      singlePrice: json['single_price'] as int,
      totalCount: json['total_count'] as int,
      totalAmount: json['total_amount'] as int,
      vehicleId: json['vehicle_id'] as String,
      loadDate: json['load_date'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert LoadData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'load_id': loadId,
      'type': type,
      'single_price': singlePrice,
      'total_count': totalCount,
      'total_amount': totalAmount,
      'vehicle_id': vehicleId,
      'load_date': loadDate,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
