import 'package:egg_factory/presentations/model_classes/shop_screen_model.dart';
import 'package:equatable/equatable.dart';

abstract class ShopScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShopScreenInitial extends ShopScreenState {}

class ShopLoading extends ShopScreenState {}

class ShopSuccess extends ShopScreenState {
  final ShopDetailsModel shopData;

  ShopSuccess(this.shopData);
  @override
  List<Object?> get props => [shopData];
}

class DeleteShopSuccess extends ShopScreenState {
  final String message; // Status Message

  DeleteShopSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class ShopFailure extends ShopScreenState {
  final String message;

  ShopFailure(this.message);

  @override
  List<Object?> get props => [message];
}
