import 'package:egg_factory/presentations/bottom_navigation_screen.dart';
import 'package:egg_factory/presentations/walk_through_screen.dart';
import 'package:egg_factory/routes/generated_routes.dart';
import 'package:egg_factory/utils/auth_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EGG FACTORY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator().generateRoute,
      home: FutureBuilder<bool>(
        future: _checkAuthentication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the result, show a loading spinner
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data == true) {
            // If the user is authenticated, navigate to the dashboard
            return BottomNavigationScreen();
          }
          // If not authenticated, navigate to the login screen
          return WalkThroughScreen();
        },
      ),
    );
  }

  Future<bool> _checkAuthentication() async {
    TokenStorage tokenStorage = TokenStorage();
    final accessToken = await tokenStorage.getAccessToken(); // Await the result
    return accessToken != null; // Return true if the token exists
  }
}
