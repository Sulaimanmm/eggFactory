import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../service/api_services.dart';
import '../../../utils/ResponseHandler.dart';

part 'otp_verification_screen_event.dart';
part 'otp_verification_screen_state.dart';

class OtpVerificationScreenBloc
    extends Bloc<OtpVerificationScreenEvent, OtpVerificationScreenState> {
  final ApiService apiService;

  OtpVerificationScreenBloc(this.apiService)
      : super(OtpVerificationScreenInitial()) {
    on<SendOTPEvent>(_onSendOTP);
    on<ContinueButtonPressed>(_onContinueButtonPressed);
  }

  Future<void> _onSendOTP(
      SendOTPEvent event, Emitter<OtpVerificationScreenState> emit) async {
    try {
      final response = await apiService.sendOTP(event.phone);

      // Handle the response with ApiResponseUtil
      final result = ApiResponseUtil.handleResponse(response, (data) => data);

      // Emit success or failure based on the result
      emit(result.isSuccess
          ? OtpSendSuccess(result.data?['message'])
          : OtpVerificationFailure(result.errorMessage!));
    } catch (error) {
      // Use a default message if the error message is null
      final errorMessage = (error is DioException)
          ? (error.response?.data['message'] ??
              'An unknown error occurred during registration.')
          : 'Register failed: ${error.toString()}';

      emit(OtpVerificationFailure(
          errorMessage)); // Emit failure state for exceptions
    }
  }

  Future<void> _onContinueButtonPressed(ContinueButtonPressed event,
      Emitter<OtpVerificationScreenState> emit) async {
    emit(OtpVerificationLoading()); // Emit loading state
    try {
      final response = await apiService.verifyOTP(event.phone, event.otp);

      // Handle the response with ApiResponseUtil
      final result = ApiResponseUtil.handleResponse(response, (data) => data);

      // Emit success or failure based on the result
      emit(result.isSuccess
          ? OtpVerificationSuccess(result.data?['data']['valid'])
          : OtpVerificationFailure(result.errorMessage!));
    } catch (error) {
      // Use a default message if the error message is null
      final errorMessage = (error is DioException)
          ? (error.response?.data['message'] ??
              'An unknown error occurred during registration.')
          : 'Register failed: ${error.toString()}';

      emit(OtpVerificationFailure(
          errorMessage)); // Emit failure state for exceptions
    }
  }
}
