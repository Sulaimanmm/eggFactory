// seller_state.dart
import 'package:equatable/equatable.dart';

import '../../model_classes/seller_screen_model.dart';

abstract class SellerScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class SellerInitial extends SellerScreenState {}

class SellerLoading extends SellerScreenState {}

class FetchSellerSuccess extends SellerScreenState {
  final SellerDetailsModel sellerData; // List of SellerInfo

  FetchSellerSuccess(this.sellerData);

  @override
  List<Object> get props =>
      [sellerData]; // Override to include the list of sellers
}

class AddSellerSuccess extends SellerScreenState {
  final String message; // Status Message

  AddSellerSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class DeleteSellerSuccess extends SellerScreenState {
  final String message; // Status Message

  DeleteSellerSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UpdateSellerSuccess extends SellerScreenState {
  final String message; // Status Message

  UpdateSellerSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class SellerFailure extends SellerScreenState {
  final String message;

  SellerFailure(this.message);

  @override
  List<Object> get props => [message]; // Override to include the error message
}
