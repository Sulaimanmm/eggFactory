import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:egg_factory/presentations/model_classes/RegisterModel.dart';
import 'package:equatable/equatable.dart';

import '../../../service/api_services.dart';
import '../../../utils/ResponseHandler.dart';
import '../../../utils/auth_preference.dart';

part 'register_screen_event.dart';
part 'register_screen_state.dart';

class RegisterScreenBloc
    extends Bloc<RegisterScreenEvent, RegisterScreenState> {
  final ApiService apiService;

  RegisterScreenBloc(this.apiService) : super(RegisterScreenInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
      RegisterButtonPressed event, Emitter<RegisterScreenState> emit) async {
    emit(RegisterLoading()); // Emit loading state
    try {
      final response =
          await apiService.register(event.email, event.phone, event.password);

      // Handle the response with ApiResponseUtil
      final result = ApiResponseUtil.handleResponse(
          response, (data) => RegisterModel.fromJson(data));

      // Save tokens in SharedPreferences
      TokenStorage tokenStorage = TokenStorage();
      await tokenStorage.saveTokens(result.data.data?.accessToken ?? "",
          result.data.data?.refreshToken ?? "", result.data.data?.authId ?? "");

      // Emit success or failure based on the result
      emit(result.isSuccess
          ? RegisterSuccess(result.data!)
          : RegisterFailure(result.errorMessage!));
    } catch (error) {
      // Use a default message if the error message is null
      final errorMessage = (error is DioException)
          ? (error.response?.data['message'] ??
              'An unknown error occurred during registration.')
          : 'Register failed: ${error.toString()}';

      emit(RegisterFailure(errorMessage)); // Emit failure state for exceptions
    }
  }
}
