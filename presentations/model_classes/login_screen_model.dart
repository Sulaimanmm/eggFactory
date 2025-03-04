class LoginModel {
  int? statusCode;
  Data? data;
  String? message;

  LoginModel({this.statusCode, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? authId;
  String? role;
  String? accessToken;
  String? refreshToken;

  Data({this.authId, this.role, this.accessToken, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    authId = json['auth_id'];
    role = json['role'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_id'] = this.authId;
    data['role'] = this.role;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
