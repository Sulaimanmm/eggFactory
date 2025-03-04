class ExpensesModel {
  int? statusCode;
  List<Data>? data;
  String? message;

  ExpensesModel({this.statusCode, this.data, this.message});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
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
  String? expenseId;
  String? vehicleId;
  String? description;
  int? spent;
  String? date;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.expenseId,
      this.vehicleId,
      this.description,
      this.spent,
      this.date,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    expenseId = json['expense_id'];
    vehicleId = json['vehicle_id'];
    description = json['description'];
    spent = json['spent'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expense_id'] = this.expenseId;
    data['vehicle_id'] = this.vehicleId;
    data['description'] = this.description;
    data['spent'] = this.spent;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
