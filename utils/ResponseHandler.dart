import 'package:dio/dio.dart';

class ResponseHandler<T> {
  T? data;
  String? errorMessage;
  bool isSuccess;

  ResponseHandler.success(this.data)
      : isSuccess = true,
        errorMessage = null;

  ResponseHandler.failure(this.errorMessage)
      : isSuccess = false,
        data = null;
}

class ApiResponseUtil {
  static ResponseHandler handleResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse success response and map it to the given model type
        final data = fromJson(response.data);
        return ResponseHandler.success(data);
      } else {
        // Handle known error status codes
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return _handleDioError(e);
    }
  }

  static ResponseHandler _handleErrorResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        return ResponseHandler.failure("Invalid request");
      case 401:
        return ResponseHandler.failure("Unauthorized access");
      case 403:
        return ResponseHandler.failure("Forbidden access");
      case 404:
        return ResponseHandler.failure("Resource not found");
      case 500:
        // Check if a specific message is provided by the server
        final message =
            response.data?['message'] ?? "Server error, please try again later";
        return ResponseHandler.failure(message);
      default:
        return ResponseHandler.failure(
          "Unexpected error occurred (Code: ${response.statusCode})",
        );
    }
  }

  static ResponseHandler _handleDioError(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ResponseHandler.failure("Connection timeout");
        case DioExceptionType.sendTimeout:
          return ResponseHandler.failure("Send timeout");
        case DioExceptionType.receiveTimeout:
          return ResponseHandler.failure("Receive timeout");
        case DioExceptionType.cancel:
          return ResponseHandler.failure("Request to server was cancelled");
        case DioExceptionType.unknown:
          return ResponseHandler.failure(
              "Network error - please check your connection");
        default:
          return ResponseHandler.failure("Unknown");
      }
    }
    // Handle any other error not specific to Dio
    return ResponseHandler.failure("An unexpected error occurred");
  }
}
