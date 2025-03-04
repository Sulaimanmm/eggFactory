import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_event.dart';
import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_state.dart';
import 'package:egg_factory/presentations/model_classes/shop_screen_model.dart';
import 'package:egg_factory/service/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreenBloc extends Bloc<ShopScreenEvent, ShopScreenState> {
  final ApiService apiService;
  ShopScreenBloc(this.apiService) : super(ShopScreenInitial()) {
    on<FetchShopDataEvent>(_onShopRequest);
    on<AddShopEvent>(_addShopRequest);
    on<DeleteShopEvent>(_deleteShopRequest);
  }

  Future<void> _onShopRequest(event, emit) async {
    emit(ShopLoading());
    try {
      final response = await apiService.getShop();
      if (response.statusCode == 200) {
        final dataResponse = ShopDetailsModel.fromJson(response.data);
        emit(ShopSuccess(dataResponse));
      } else {
        emit(ShopFailure(response.statusMessage ?? 'Loading error'));
      }
    } catch (error) {
      emit(ShopFailure('Loading Failure ${error.toString()}'));
    }
  }

  Future<void> _addShopRequest(AddShopEvent event, emit) async {
    emit(ShopLoading());
    try {
      final response = await apiService.addShop(
        {
          "name": event.name,
          "vehicle_id": event.sellerId,
          "dealer_id": event.dealerId,
          "location_id": event.locationId,
          "credit": event.credit,
          "phone": event.phone,
          "address": event.address,
          "crate_data": {
            "tray_balance": event.trayBalance,
          }
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dataResponse = ShopDetailsModel.fromJson(response.data);
        emit(ShopSuccess(dataResponse));
      } else {
        emit(ShopFailure(response.statusMessage ?? 'Loading error'));
      }
    } catch (error) {
      emit(ShopFailure('Loading Failure ${error.toString()}'));
    }
  }

  Future<void> _deleteShopRequest(DeleteShopEvent event, emit) async {
    emit(ShopLoading());
    try {
      final response = await apiService.deleteShop(event.shopId);
      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map the response data to the LoginResponse model
        final statusMessage = response.data['message'];
        emit(DeleteShopSuccess(statusMessage)); // Emit success state
      } else {
        emit(ShopFailure(
          response.statusMessage ?? "Deleted failed",
        )); // Emit failure with the status message
      }
    } catch (error) {
      emit(ShopFailure(
        'Login failed: ${error.toString()}',
      )); // Emit failure state in case of an error
    }
  }
}
