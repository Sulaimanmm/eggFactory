part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchDealerEvent extends HomeScreenEvent {}
