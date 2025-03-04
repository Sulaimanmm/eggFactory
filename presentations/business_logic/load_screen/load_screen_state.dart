part of 'load_screen_bloc.dart';

abstract class LoadScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadScreenInitial extends LoadScreenState {}

class LoadLoading extends LoadScreenState {}

class LoadSuccess extends LoadScreenState {
  final LoadModel loadedData;

  LoadSuccess(this.loadedData);
  @override
  List<Object> get props => [loadedData];
}

class LoadFailure extends LoadScreenState {
  final String message;

  LoadFailure(this.message);
  @override
  List<Object> get props => [message];
}
