import 'package:equatable/equatable.dart';

abstract class ShopScreenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchShopDataEvent extends ShopScreenEvent {}

class AddShopEvent extends ShopScreenEvent {
  final String name;
  final String sellerId;
  final String dealerId;
  final String locationId;
  final int credit;
  final int phone;
  final String address;
  final String trayBalance;

  AddShopEvent(
      {required this.name,
      required this.sellerId,
      required this.dealerId,
      required this.locationId,
      required this.credit,
      required this.phone,
      required this.address,
      required this.trayBalance});

  // // Method to generate the data map
  // Map<String, dynamic> toMap() {
  //   return {
  //     "name": name,
  //     "vehicle_id": sellerId,
  //     "dealer_id": dealerId,
  //     "location_id": locationId,
  //     "credit": credit,
  //     "phone": phone,
  //     "address": address,
  //     "crate_data": {
  //       "tray_balance": trayBalance,
  //     },
  //   };
  // }
}

class DeleteShopEvent extends ShopScreenEvent {
  final String shopId;

  DeleteShopEvent({required this.shopId});
}

class UpdateShopEvent extends ShopScreenEvent {}
