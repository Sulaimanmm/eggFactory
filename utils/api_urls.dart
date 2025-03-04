class ApiUrls {
  static const baseURL = 'https://dev-eggapp-api.onrender.com/api/v1/';
  static const logIn = '${baseURL}auth/login';
  static const refresh = '${baseURL}auth/refresh';
  static const register = '${baseURL}auth/register';
  static const sendOTP = '${baseURL}otp/send';
  static const verifyOTP = '${baseURL}otp/verify';

  // sellers
  static const addSeller = '${baseURL}vehicle';
  static const getSeller = '${baseURL}vehicle';
  static const deleteSeller =
      '${baseURL}vehicle/'; // add sellerId after vehicle/
  static const updateSeller =
      '${baseURL}vehicle/update/'; // add sellerId after update/

  // areas
  static const getArea =
      '${baseURL}location/dealer/'; // add dealerId after dealer/
  static const addArea = '${baseURL}location';
  static const deleteArea = '${baseURL}location/'; // add areaId after location/

  //shops
  static const getShop = '${baseURL}shops';
  static const addShop = '${baseURL}shops';
  static const deleteShop = '${baseURL}shops/'; // add shopId after location/

  static const getDealer = '${baseURL}dealer/auth/'; // add authId after auth/

  //loads
  static const getLoad = '${baseURL}load';

  //expenses
  static const getExpenses = '${baseURL}expenses';
}
