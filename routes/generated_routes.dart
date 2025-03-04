import 'package:egg_factory/network/dio_client.dart';
import 'package:egg_factory/presentations/bottom_navigation_inside_screens/load_view_screen.dart';
import 'package:egg_factory/presentations/business_logic/area_screen/area_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/expenses_screen/expenses_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/load_screen/load_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_bloc.dart';
import 'package:egg_factory/service/api_services.dart';
import 'package:egg_factory/utils/auth_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentations/bottom_navigation_inside_screens/add_area_screen.dart';
import '../presentations/bottom_navigation_inside_screens/add_seller_screen.dart';
import '../presentations/bottom_navigation_inside_screens/add_shop_screen.dart';
import '../presentations/bottom_navigation_screen.dart';
import '../presentations/business_logic/log_in_screen/log_in_screen_bloc.dart';
import '../presentations/business_logic/otp_verification_screen/otp_verification_screen_bloc.dart';
import '../presentations/business_logic/profile_screen/profile_screen_bloc.dart';
import '../presentations/business_logic/register_screen/register_screen_bloc.dart';
import '../presentations/landing_screen.dart';
import '../presentations/login_screen.dart';
import '../presentations/otp_verification_screen.dart';
import '../presentations/profile_screen.dart';
import '../presentations/register_screen.dart';
import '../presentations/walk_through_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final apiService = ApiService(DioClient(), TokenStorage());
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WalkThroughScreen(),
        );
      case '/landingScreen':
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
        );
      case '/logInScreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: LoginBloc(apiService),
            child: const LogInScreen(),
          ),
        );
      case '/registerScreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: RegisterScreenBloc(apiService),
            child: const RegisterScreen(),
          ),
        );
      case '/otpVerificationScreen':
        final phoneNumber =
            settings.arguments as int; // Get the phone number from arguments
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: OtpVerificationScreenBloc(apiService),
              child: OtpVerificationScreen(
                  phoneNumber: phoneNumber) // Pass the phone number here
              ),
        );
      case '/bottomNavigationScreen':
        return MaterialPageRoute(
          builder: (_) => const BottomNavigationScreen(),
        );
      case '/profileScreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: ProfileScreenBloc(),
            child: const ProfileScreen(),
          ),
        );
      case '/addSellerScreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: SellerScreenBloc(apiService), child: AddSellerScreen()),
        );
      case '/addAreaScreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AreaScreenBloc(apiService)),
              BlocProvider(create: (context) => SellerScreenBloc(apiService)),
            ],
            child: AddAreaScreen(),
          ),
        );
      case '/addShopScreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AreaScreenBloc(apiService)),
              BlocProvider(create: (context) => SellerScreenBloc(apiService)),
              BlocProvider(create: (context) => ShopScreenBloc(apiService))
            ],
            child: AddShopScreen(),
          ),
        );
      case '/loadViewScreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ExpensesScreenBloc(apiService)),
              BlocProvider(create: (context) => LoadScreenBloc(apiService))
            ],
            child: LoadViewScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const WalkThroughScreen(),
        );
    }
  }
}
