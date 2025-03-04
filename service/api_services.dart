import 'package:dio/dio.dart';
import 'package:egg_factory/utils/api_urls.dart';
import 'package:egg_factory/utils/auth_preference.dart';

import '../network/dio_client.dart';

class ApiService {
  final DioClient dioClient;
  final TokenStorage tokenStorage;

  ApiService(this.dioClient, this.tokenStorage);

  Future<String?> refreshToken() async {
    final refreshToken = await TokenStorage().getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dioClient.post(ApiUrls.refresh, data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 201) {
        final newAccessToken = response.data['data']['access_token'];
        await tokenStorage
            .saveAccessToken(newAccessToken); // Save the new token
        return newAccessToken;
      }
    } catch (error) {
      print('Token refresh failed: $error');
    }
    return null;
  }

  Future<Response> login(String? email, int? phone, String password) async {
    // Create a map and only include non-null values
    final Map<String, dynamic> data = {
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'password': password, // Always include password
    };

    try {
      // Call DioClient's post method
      final response = await dioClient.post(ApiUrls.logIn, data: data);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> register(String? email, int? phone, String password) async {
    // Create a map and only include non-null values
    final Map<String, dynamic> data = {
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'password': password, 'role': 'dealer' // Always include password
    };

    try {
      // Call DioClient's post method
      final response = await dioClient.post(ApiUrls.register, data: data);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> sendOTP(int phone) async {
    final Map<String, dynamic> data = {'phone': phone};
    try {
      final response = await dioClient.post(ApiUrls.sendOTP, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed :$e');
    }
  }

  Future<Response> verifyOTP(int phone, int otp) async {
    final Map<String, dynamic> data = {'phone': phone, "otp": otp};
    try {
      final response = await dioClient.post(ApiUrls.verifyOTP, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed :$e');
    }
  }

  Future<Response> getSeller() async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      final response = await dioClient.get(ApiUrls.getSeller, options: options);
      return response; // Parse the response
    } catch (e) {
      throw Exception('Failed to fetch seller details: $e');
    }
  }

  Future<Response> addSeller(Map<String, dynamic> sellerData) async {
    String? accessToken = await tokenStorage.getAccessToken();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's post method
      final response = await dioClient.post(ApiUrls.addSeller,
          data: sellerData, options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> updateSeller(
      Map<String, dynamic> updateSellerData, String sellerId) async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's post method
      final response = await dioClient.patch('${ApiUrls.updateSeller}$sellerId',
          data: updateSellerData, options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> deleteSeller(String dealerId) async {
    String? accessToken = await tokenStorage.getAccessToken();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's delete method
      final response = await dioClient
          .delete('${ApiUrls.deleteSeller}$dealerId', options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> getArea() async {
    String? accessToken = await tokenStorage.getAccessToken();
    String? dealerID = await tokenStorage.getDealerId();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      final response =
          await dioClient.get('${ApiUrls.getArea}$dealerID', options: options);
      return response; // Parse the response
    } catch (e) {
      throw Exception('Failed to fetch seller details: $e');
    }
  }

  Future<Response> addArea(Map<String, dynamic> areaData) async {
    String? accessToken = await tokenStorage.getAccessToken();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's post method
      final response = await dioClient.post(ApiUrls.addArea,
          data: areaData, options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> deleteArea(String areaId) async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's delete method
      final response = await dioClient.delete('${ApiUrls.deleteArea}$areaId',
          options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> getShop() async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(headers: {'Authorization': 'Bearer $accessToken'});
    try {
      final response = await dioClient.get(ApiUrls.getShop, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch shop details: $e');
    }
  }

  Future<Response> addShop(Map<String, dynamic> shopData) async {
    String? accessToken = await tokenStorage.getAccessToken();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken' // Set token in headers
      },
    );
    try {
      // Call DioClient's post method
      final response = await dioClient.post(ApiUrls.addShop,
          data: shopData, options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> deleteShop(String shopId) async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken', // Set token in headers
      },
    );
    try {
      // Call DioClient's delete method
      final response = await dioClient.delete('${ApiUrls.deleteShop}$shopId',
          options: options);
      return response;
    } catch (e) {
      rethrow; // Let the Bloc handle errors
    }
  }

  Future<Response> getDealer() async {
    String? authId = await tokenStorage.getAuthId();
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(headers: {'Authorization': 'Bearer $accessToken'});
    try {
      final response =
          await dioClient.get('${ApiUrls.getDealer}$authId', options: options);
      return response;
    } catch (e) {
      throw Exception('Failed :$e');
    }
  }

  Future<Response> getLoad() async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(headers: {'Authorization': 'Bearer $accessToken'});
    try {
      final response = await dioClient.get(ApiUrls.getLoad, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed :$e');
    }
  }

  Future<Response> getExpenses() async {
    String? accessToken = await tokenStorage.getAccessToken();
    final options = Options(headers: {'Authorization': 'Bearer $accessToken'});

    try {
      final response =
          await dioClient.get(ApiUrls.getExpenses, options: options);
      return response;
    } catch (e) {
      throw Exception('failed : $e');
    }
  }
// Add more methods for other API endpoints
}
