/// statusCode : 201
/// data : {"is_active":true,"auth_id":"ATH-vvsxM","phone":9876543210,"role":"dealer","updatedAt":"2024-11-04T07:46:14.592Z","createdAt":"2024-11-04T07:46:14.592Z"}
/// message : "Success"

class RegisterModel {
  RegisterModel({
    this.statusCode,
    this.data,
    this.message,
  });

  RegisterModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  num? statusCode;
  Data? data;
  String? message;
  RegisterModel copyWith({
    num? statusCode,
    Data? data,
    String? message,
  }) =>
      RegisterModel(
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        message: message ?? this.message,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  Data({
    this.isActive,
    this.authId,
    this.phone,
    this.role,
    this.updatedAt,
    this.createdAt,
    this.accessToken,
    this.refreshToken,
  });

  Data.fromJson(dynamic json) {
    isActive = json['is_active'];
    authId = json['auth_id'];
    phone = json['phone'];
    role = json['role'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
  bool? isActive;
  String? authId;
  num? phone;
  String? role;
  String? updatedAt;
  String? createdAt;
  String? accessToken;
  String? refreshToken;
  Data copyWith({
    bool? isActive,
    String? authId,
    num? phone,
    String? role,
    String? updatedAt,
    String? createdAt,
    String? accessToken,
    String? refreshToken,
  }) =>
      Data(
        isActive: isActive ?? this.isActive,
        authId: authId ?? this.authId,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_active'] = isActive;
    map['auth_id'] = authId;
    map['phone'] = phone;
    map['role'] = role;
    map['updatedAt'] = updatedAt;
    map['createdAt'] = createdAt;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }
}
