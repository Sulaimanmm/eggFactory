part of 'area_screen_bloc.dart';

abstract class AreaScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAreaDataEvent extends AreaScreenEvent {}

class AddAreaEvent extends AreaScreenEvent {
  final String areaName;
  final int pincode;
  final String sellerId;
  final String dealerId;
  final bool isActive;

  AddAreaEvent(
      {required this.areaName,
      required this.pincode,
      required this.sellerId,
      required this.dealerId,
      required this.isActive});
}

class DeleteAreaEvent extends AreaScreenEvent {
  final String areaId;

  DeleteAreaEvent({required this.areaId});
}

class UpdateAreaEvent extends AreaScreenEvent {}
