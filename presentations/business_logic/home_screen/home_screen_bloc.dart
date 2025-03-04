import 'package:bloc/bloc.dart';
import 'package:egg_factory/presentations/model_classes/dealer_model.dart';
import 'package:equatable/equatable.dart';

import '../../../service/api_services.dart';
import '../../../utils/auth_preference.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;
  HomeScreenBloc(this.apiService) : super(HomeScreenInitial()) {
    on<HomeScreenEvent>(_onFetchDealer);
  }

  Future<void> _onFetchDealer(event, emit) async {
    emit(HomeScreenLoading()); // Emit loading state
    try {
      // Make the POST request using DioClient
      final response = await apiService.getDealer();

      // Check the response status code
      if (response.statusCode == 200) {
        // Map the response data to the LoginResponse model
        final dataResponse = DealerModel.fromJson(response.data);
        TokenStorage tokenStorage = TokenStorage();
        await tokenStorage.saveDealerId(dataResponse.data?.dealerId ?? "");
        emit(HomeScreenSuccess(dataResponse)); // Emit success state
      } else {
        emit(HomeScreenFailure(
          response.statusMessage ?? "Login failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(HomeScreenFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }
}
