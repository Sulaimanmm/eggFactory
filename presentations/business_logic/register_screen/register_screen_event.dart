part of 'register_screen_bloc.dart';

abstract class RegisterScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterScreenEvent {
  final String? email;
  final int? phone;
  final String password;

  RegisterButtonPressed({
    this.email,
    this.phone,
    required this.password,
  });

  @override
  List<Object> get props =>
      [email ?? "", phone ?? 0, password]; // Allow nulls here
}
