part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSuccess extends HomeScreenState {
  final DealerModel dealerData; // List of SellerInfo

  const HomeScreenSuccess(this.dealerData);

  @override
  List<Object> get props =>
      [dealerData]; // Override to include the list of sellers
}

class HomeScreenFailure extends HomeScreenState {
  final String message;

  const HomeScreenFailure(this.message);

  @override
  List<Object> get props => [message]; // Override to include the error message
}
