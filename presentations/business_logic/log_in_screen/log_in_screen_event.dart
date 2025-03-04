import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String? email;
  final int? phone;
  final String password;

  LoginButtonPressed({
    this.email,
    this.phone,
    required this.password,
  });

  @override
  List<Object> get props =>
      [email ?? "", phone ?? 0, password]; // Allow nulls here
}
