import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/route_config.dart';
import '../utils/resources.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style:
              TextStyle(fontSize: 18.sp, fontFamily: FontSources.interRegular),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(IconSource.backArrowIcon),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          ImageSource.premiumImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Account",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: FontSources.interBold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      leading: Image.asset(
                        IconSource.personIcon,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                      ),
                      trailing: Image.asset(
                        IconSource.forwardArrowIcon,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Image.asset(
                        IconSource.passwordIcon,
                      ),
                      title: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                      ),
                      trailing: Image.asset(
                        IconSource.forwardArrowIcon,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Image.asset(
                        IconSource.notificationIcon,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                      ),
                      trailing: Image.asset(
                        IconSource.forwardArrowIcon,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'More',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: FontSources.interBold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      leading: Image.asset(
                        IconSource.reviewIcon,
                      ),
                      title: Text(
                        'Rate & Review',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                      ),
                      trailing: Image.asset(
                        IconSource.forwardArrowIcon,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Image.asset(
                        IconSource.helpIcon,
                      ),
                      title: Text(
                        'Help',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                      ),
                      trailing: Image.asset(
                        IconSource.forwardArrowIcon,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, logInScreen);
              },
              child: Text(
                'Log out',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontSources.interRegular,
                    color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
