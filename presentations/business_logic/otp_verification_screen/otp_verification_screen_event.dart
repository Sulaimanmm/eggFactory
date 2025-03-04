part of 'otp_verification_screen_bloc.dart';

abstract class OtpVerificationScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOTPEvent extends OtpVerificationScreenEvent {
  final int phone;

  SendOTPEvent({
    required this.phone,
  });

  @override
  List<Object> get props => [phone]; // Allow nulls here
}

class ContinueButtonPressed extends OtpVerificationScreenEvent {
  final int phone;
  final int otp;

  ContinueButtonPressed({
    required this.phone,
    required this.otp,
  });

  @override
  List<Object> get props => [phone, otp]; // Allow nulls here
}
