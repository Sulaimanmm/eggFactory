part of 'load_screen_bloc.dart';

abstract class LoadScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchLoadEvent extends LoadScreenEvent {}
