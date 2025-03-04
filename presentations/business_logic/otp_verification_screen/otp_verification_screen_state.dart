part of 'otp_verification_screen_bloc.dart';

abstract class OtpVerificationScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpVerificationScreenInitial extends OtpVerificationScreenState {}

class OtpVerificationLoading extends OtpVerificationScreenState {}

class OtpSendSuccess extends OtpVerificationScreenState {
  final String message;

  OtpSendSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OtpVerificationSuccess extends OtpVerificationScreenState {
  final bool message;

  OtpVerificationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OtpVerificationFailure extends OtpVerificationScreenState {
  final String error;

  OtpVerificationFailure(this.error);

  @override
  List<Object> get props => [error];
}
