class DealerModel {
  int? statusCode;
  Data? data;
  String? message;

  DealerModel({this.statusCode, this.data, this.message});

  DealerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? name;
  String? dealerId;
  String? authId;
  bool? isActive;
  bool? isVerified;
  String? gstNo;
  String? streetAddress;
  String? city;
  String? state;
  String? zipcode;
  int? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  UserSubscription? userSubscription;

  Data(
      {this.name,
      this.dealerId,
      this.authId,
      this.isActive,
      this.isVerified,
      this.gstNo,
      this.streetAddress,
      this.city,
      this.state,
      this.zipcode,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.userSubscription});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dealerId = json['dealer_id'];
    authId = json['auth_id'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    gstNo = json['gst_no'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userSubscription = json['user_subscription'] != null
        ? new UserSubscription.fromJson(json['user_subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['dealer_id'] = dealerId;
    data['auth_id'] = authId;
    data['is_active'] = isActive;
    data['is_verified'] = isVerified;
    data['gst_no'] = gstNo;
    data['street_address'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['zipcode'] = zipcode;
    data['phone'] = phone;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (userSubscription != null) {
      data['user_subscription'] = userSubscription!.toJson();
    }
    return data;
  }
}

class UserSubscription {
  String? dealerId;
  String? userSubId;
  String? razorPayId;
  String? subId;
  bool? isActive;
  String? expiredIn;
  bool? autoRenew;
  bool? paymentDone;
  int? amountPaid;
  String? createdAt;
  String? updatedAt;
  Subscription? subscription;

  UserSubscription(
      {this.dealerId,
      this.userSubId,
      this.razorPayId,
      this.subId,
      this.isActive,
      this.expiredIn,
      this.autoRenew,
      this.paymentDone,
      this.amountPaid,
      this.createdAt,
      this.updatedAt,
      this.subscription});

  UserSubscription.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealer_id'];
    userSubId = json['user_sub_id'];
    razorPayId = json['razor_pay_id'];
    subId = json['sub_id'];
    isActive = json['is_active'];
    expiredIn = json['expired_in'];
    autoRenew = json['auto_renew'];
    paymentDone = json['payment_done'];
    amountPaid = json['amount_paid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dealer_id'] = dealerId;
    data['user_sub_id'] = userSubId;
    data['razor_pay_id'] = razorPayId;
    data['sub_id'] = subId;
    data['is_active'] = isActive;
    data['expired_in'] = expiredIn;
    data['auto_renew'] = autoRenew;
    data['payment_done'] = paymentDone;
    data['amount_paid'] = amountPaid;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  String? name;
  String? subId;
  int? validity;
  int? price;
  String? description;
  bool? isActive;
  int? crateCount;
  int? shopsCount;
  int? vehicleCount;
  int? locationCount;
  String? createdAt;
  String? updatedAt;

  Subscription(
      {this.name,
      this.subId,
      this.validity,
      this.price,
      this.description,
      this.isActive,
      this.crateCount,
      this.shopsCount,
      this.vehicleCount,
      this.locationCount,
      this.createdAt,
      this.updatedAt});

  Subscription.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subId = json['sub_id'];
    validity = json['validity'];
    price = json['price'];
    description = json['description'];
    isActive = json['is_active'];
    crateCount = json['crate_count'];
    shopsCount = json['shops_count'];
    vehicleCount = json['vehicle_count'];
    locationCount = json['location_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['sub_id'] = subId;
    data['validity'] = validity;
    data['price'] = price;
    data['description'] = description;
    data['is_active'] = isActive;
    data['crate_count'] = crateCount;
    data['shops_count'] = shopsCount;
    data['vehicle_count'] = vehicleCount;
    data['location_count'] = locationCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
