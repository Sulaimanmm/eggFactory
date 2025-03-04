import 'package:egg_factory/presentations/business_logic/load_screen/load_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/dio_client.dart';
import '../service/api_services.dart';
import '../utils/auth_preference.dart';
import '../utils/resources.dart';
import 'bottom_navigation_inside_screens/home_screen.dart';
import 'bottom_navigation_inside_screens/load_screen.dart';
import 'bottom_navigation_inside_screens/manage_screen.dart';
import 'bottom_navigation_inside_screens/subscription_screen.dart';
import 'business_logic/area_screen/area_screen_bloc.dart';
import 'business_logic/home_screen/home_screen_bloc.dart';
import 'business_logic/seller_screen/seller_screen_bloc.dart';
import 'business_logic/shop_screen/shop_screen_bloc.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final _screens = [
    BlocProvider(
      create: (context) => HomeScreenBloc(
        ApiService(DioClient(), TokenStorage()),
      ),
      child: const HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SellerScreenBloc(ApiService(DioClient(), TokenStorage())),
        ),
        BlocProvider(
          create: (context) =>
              AreaScreenBloc(ApiService(DioClient(), TokenStorage())),
        ),
        BlocProvider(
          create: (context) =>
              ShopScreenBloc(ApiService(DioClient(), TokenStorage())),
        ),
      ],
      child: const ManageScreen(),
    ),
    const SubscriptionScreen(),
    BlocProvider(
      create: (context) =>
          LoadScreenBloc(ApiService(DioClient(), TokenStorage())),
      child: LoadScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: bottomNavItems,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          selectedItemColor: ColorSources.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(IconSource.homeNavigationBarIcon),
    ),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(IconSource.manageNavigationBarIcon),
    ),
    label: 'Manage',
  ),
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(IconSource.subscriptionNavigationBarIcon),
    ),
    label: 'Subscription',
  ),
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(IconSource.loadNavigationBarIcon),
    ),
    label: 'Load',
  )
];
