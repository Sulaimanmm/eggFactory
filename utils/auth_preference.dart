import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String authIds = 'auth_id';
  static const String dealerIds = 'dealer_id';

  // Save access and refresh tokens
  Future<void> saveTokens(
      String accessToken, String refreshToken, String authId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store the tokens
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
    await prefs.setString(authIds, authId);
  }

  Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
  }

  Future<void> saveDealerId(String dealerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(dealerIds, dealerId);
  }

  // Get authId
  Future<String?> getAuthId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authIds);
  }

  // Get dealerId
  Future<String?> getDealerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(dealerIds);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  // Remove tokens (for logout)
  Future<void> removeTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(authIds);
    await prefs.remove(dealerIds);
  }
}

class UserDetailsStorage {
  static const String name = 'name';
  static const String isActive = 'isActive';
  static const String isVerified = 'isVerified';
  static const String gstNo = 'gstNo';
  static const String streetAddress = 'street_address';
  static const String city = 'city';
  static const String state = 'state';
  static const String zipCode = 'zipCode';
  static const String phone = 'phone';
  static const String email = 'email';

  Future<void> saveUser(
      String nameKey,
      bool isActiveKey,
      bool isVerifiedKey,
      int gstNoKey,
      String streetAddressKey,
      String cityKey,
      String stateKey,
      int zipCodeKey,
      int phoneKey,
      String emailKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, name);
    await prefs.setBool(isActive, isActiveKey);
    await prefs.setBool(isVerified, isVerifiedKey);
    await prefs.setInt(gstNo, gstNoKey);
    await prefs.setString(streetAddress, streetAddressKey);
    await prefs.setString(city, cityKey);
    await prefs.setString(state, stateKey);
    await prefs.setInt(zipCode, zipCodeKey);
    await prefs.setInt(phone, phoneKey);
    await prefs.setString(email, emailKey);
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  Future<String?> getIsActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(isActive);
  }

  Future<String?> getIsVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(isVerified);
  }

  Future<String?> getStreetAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(streetAddress);
  }

  Future<String?> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(city);
  }

  Future<String?> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(state);
  }

  Future<String?> getZipCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(zipCode);
  }

  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phone);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(email);
  }

  Future<void> removeTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
    await prefs.remove(isActive);
    await prefs.remove(isVerified);
    await prefs.remove(gstNo);
    await prefs.remove(streetAddress);
    await prefs.remove(state);
    await prefs.remove(city);
    await prefs.remove(zipCode);
    await prefs.remove(phone);
    await prefs.remove(email);
  }
}
