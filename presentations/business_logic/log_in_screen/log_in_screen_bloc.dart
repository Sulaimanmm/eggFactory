import 'package:egg_factory/presentations/model_classes/login_screen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/api_services.dart';
import '../../../utils/auth_preference.dart';
import 'log_in_screen_event.dart';
import 'log_in_screen_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService; // Using ApiService
  // final FlutterSecureStorage _storage = FlutterSecureStorage();

  LoginBloc(this.apiService) : super(LoginInitial()) {
    // Ensure the mapping function is connected
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  // Event handler for login
  Future<void> _onLoginButtonPressed(event, emit) async {
    emit(LoginLoading()); // Emit loading state
    try {
      // Make the POST request using DioClient
      final response =
          await apiService.login(event.email, event.phone, event.password);

      // Check the response status code
      if (response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final dataResponse = LoginModel.fromJson(response.data);

        final role =
            dataResponse.data?.role ?? ""; // Extract role from the response
        // Save tokens in SharedPreferences
        TokenStorage tokenStorage = TokenStorage();
        await tokenStorage.saveTokens(
            dataResponse.data?.accessToken ?? "",
            dataResponse.data?.refreshToken ?? "",
            dataResponse.data?.authId ?? "");
        emit(LoginSuccess(role)); // Emit success state
      } else {
        emit(LoginFailure(
          response.statusMessage ?? "Login failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(LoginFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }
}
