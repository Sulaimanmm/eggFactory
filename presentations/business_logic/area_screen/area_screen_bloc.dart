import 'package:bloc/bloc.dart';
import 'package:egg_factory/presentations/model_classes/area_screen_model.dart';
import 'package:equatable/equatable.dart';

import '../../../service/api_services.dart';

part 'area_screen_event.dart';
part 'area_screen_state.dart';

class AreaScreenBloc extends Bloc<AreaScreenEvent, AreaScreenState> {
  final ApiService apiService; // Using ApiService

  AreaScreenBloc(this.apiService) : super(AreaScreenInitial()) {
    on<AreaScreenEvent>(_onAreaRequest);
    on<AddAreaEvent>(_addAreaRequest);
    on<DeleteAreaEvent>(_deleteAreaRequest);
  }

  Future<void> _onAreaRequest(event, emit) async {
    emit(AreaScreenLoading()); // Emit loading state
    try {
      // Make the POST request using DioClient
      final response = await apiService.getArea();

      // Check the response status code
      if (response.statusCode == 200) {
        // Map the response data to the LoginResponse model
        final dataResponse = AreaDetailsModel.fromJson(response.data);
        emit(FetchAreaSuccess(dataResponse)); // Emit success state
      } else {
        emit(AreaScreenFailure(
          response.statusMessage ?? "Login failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(AreaScreenFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }

  Future<void> _addAreaRequest(AddAreaEvent event, emit) async {
    emit(AreaScreenLoading()); // Emit loading state
    try {
      // Make the POST request using DioClient
      final response = await apiService.addArea({
        "name": event.areaName,
        "vehicle_id": event.sellerId,
        "dealer_id": event.dealerId,
        "is_active": event.isActive,
        "zipcode": event.pincode
      });

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(AddAreaSuccess(statusMessage)); // Emit success state
      } else {
        emit(AreaScreenFailure(
          response.statusMessage ?? "Added failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(AreaScreenFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }

  Future<void> _deleteAreaRequest(DeleteAreaEvent event, emit) async {
    emit(AreaScreenLoading()); // Emit loading state
    try {
      // Make the Delete request using DioClient
      final response = await apiService.deleteArea(event.areaId);

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(DeleteAreaSuccess(statusMessage)); // Emit success state
      } else {
        emit(AreaScreenFailure(
          response.statusMessage ?? "Deleted failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(AreaScreenFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }
}
