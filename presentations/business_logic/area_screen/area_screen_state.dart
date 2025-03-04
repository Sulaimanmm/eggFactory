part of 'area_screen_bloc.dart';

abstract class AreaScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class AreaScreenInitial extends AreaScreenState {}

class AreaScreenLoading extends AreaScreenState {}

class FetchAreaSuccess extends AreaScreenState {
  final AreaDetailsModel areaData; // List of SellerInfo

  FetchAreaSuccess(this.areaData);

  @override
  List<Object> get props =>
      [areaData]; // Override to include the list of sellers
}

class AddAreaSuccess extends AreaScreenState {
  final String message; // Status Message

  AddAreaSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class DeleteAreaSuccess extends AreaScreenState {
  final String message; // Status Message

  DeleteAreaSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UpdateAreaSuccess extends AreaScreenState {
  final String message; // Status Message

  UpdateAreaSuccess(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class AreaScreenFailure extends AreaScreenState {
  final String message;

  AreaScreenFailure(this.message);

  @override
  List<Object> get props => [message]; // Override to include the error message
}
