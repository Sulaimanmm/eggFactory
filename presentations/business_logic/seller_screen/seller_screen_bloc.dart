// seller_bloc.dart
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_event.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/api_services.dart';
import '../../model_classes/seller_screen_model.dart';

class SellerScreenBloc extends Bloc<SellerScreenEvent, SellerScreenState> {
  final ApiService apiService; // Using ApiService

  SellerScreenBloc(this.apiService) : super(SellerInitial()) {
    on<FetchSellersEvent>(_onSellerRequest);
    on<AddSellerEvent>(_addSellerRequest);
    on<DeleteSellerEvent>(_deleteSellerRequest);
    on<UpdateSellerEvent>(_updateSellerRequest);
  }

  Future<void> _onSellerRequest(event, emit) async {
    emit(SellerLoading()); // Emit loading state
    try {
      // Make the get request using DioClient
      final response = await apiService.getSeller();

      // Check the response status code
      if (response.statusCode == 200) {
        // Map the response data to the LoginResponse model
        final dataResponse = SellerDetailsModel.fromJson(response.data);
        emit(FetchSellerSuccess(dataResponse)); // Emit success state
      } else {
        emit(SellerFailure(
          response.statusMessage ?? "Login failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(SellerFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }

  Future<void> _addSellerRequest(AddSellerEvent event, emit) async {
    emit(SellerLoading()); // Emit loading state
    try {
      // Make the POST request using DioClient
      final response = await apiService.addSeller({
        "vehicle_no": event.vehicleNo,
        "dealer_id": event.dealerId,
        "name": event.name,
        "is_active": event.isActive,
        "password": event.password,
        "phone": event.phone,
      });

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(AddSellerSuccess(statusMessage)); // Emit success state
      } else {
        emit(SellerFailure(
          response.statusMessage ?? "Added failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(SellerFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }

  Future<void> _updateSellerRequest(event, emit) async {
    emit(SellerLoading()); // Emit loading state
    try {
      // Make the Patch request using DioClient
      final response = await apiService.updateSeller({
        "vehicle_no": event.vehicleNo,
        "dealer_id": event.dealerId,
        "name": event.name,
        "is_active": event.isActive,
        "password": event.password,
        "phone": event.phone,
      }, "dealerId");

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(UpdateSellerSuccess(statusMessage)); // Emit success state
      } else {
        emit(SellerFailure(
          response.statusMessage ?? "Added failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(SellerFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }

  Future<void> _deleteSellerRequest(event, emit) async {
    emit(SellerLoading()); // Emit loading state
    try {
      // Make the Delete request using DioClient
      final response = await apiService.deleteSeller(event.vehicleId);

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(DeleteSellerSuccess(statusMessage)); // Emit success state
      } else {
        emit(SellerFailure(
          response.statusMessage ?? "Deleted failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(SellerFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }
}
