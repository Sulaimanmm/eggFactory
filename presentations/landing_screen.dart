import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/route_config.dart';
import '../utils/resources.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              child: Text(
                'eggfactory',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: FontSources.interBold,
                    color: ColorSources.primaryColor),
              ),
            ),
            CarouselSlider(
              items: _items,
              options: CarouselOptions(
                  height: 420.h,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
            ),
            DotsIndicator(
              dotsCount: _items.length,
              position: activeIndex,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, registerScreen);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(182.w, 48.h),
                  foregroundColor: Colors.white,
                  backgroundColor: ColorSources.primaryColor),
              child: Text(
                'Create account',
                style: TextStyle(
                    fontSize: 16.sp, fontFamily: FontSources.interMedium),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an account?',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontSources.interRegular,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, logInScreen);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: FontSources.interRegular,
                          fontWeight: FontWeight.w500,
                          color: ColorSources.primaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  final List<Widget> _items = [
    _buildItem(ImageSource.carouselLogo1, "Create brilliant app to manage"),
    _buildItem(ImageSource.carouselLogo1, "Create brilliant 2app to manage"),
  ];

  static Widget _buildItem(String imagePath, String description) {
    return Column(
      children: [
        Image.asset(imagePath),
        Text(
          description,
          style: TextStyle(fontSize: 24.sp, fontFamily: FontSources.interBold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
