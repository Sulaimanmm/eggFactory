import 'package:equatable/equatable.dart';

abstract class SellerScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSellersEvent extends SellerScreenEvent {}

class AddSellerEvent extends SellerScreenEvent {
  final String vehicleNo;
  final String dealerId;
  final String name;
  final bool isActive;
  final String password;
  final int phone;

  AddSellerEvent({
    required this.vehicleNo,
    required this.dealerId,
    required this.name,
    required this.isActive,
    required this.password,
    required this.phone,
  });
}

class DeleteSellerEvent extends SellerScreenEvent {
  final String vehicleId;

  DeleteSellerEvent({required this.vehicleId});
}

class UpdateSellerEvent extends SellerScreenEvent {}
