part of 'register_screen_bloc.dart';

abstract class RegisterScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

final class RegisterScreenInitial extends RegisterScreenState {}

class RegisterLoading extends RegisterScreenState {}

class RegisterSuccess extends RegisterScreenState {
  final RegisterModel registerData;

  RegisterSuccess(this.registerData);

  @override
  List<Object> get props => [registerData];
}

class RegisterFailure extends RegisterScreenState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}
