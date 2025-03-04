import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/route_config.dart';
import '../utils/resources.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageSource.splashLogo),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                "eggfactory",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: FontSources.interSemiBold,
                    color: Colors.white),
              ),
            ),
            const Text(
              "Easy to manage egg selling with us",
              style: TextStyle(fontSize: 32, fontFamily: FontSources.interBold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, landingScreen);
                },
                child: const Text(
                  'Get started',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontSources.interMedium,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
