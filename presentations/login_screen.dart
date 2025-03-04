import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/resources.dart';
import 'bottom_navigation_screen.dart';
import 'business_logic/log_in_screen/log_in_screen_bloc.dart';
import 'business_logic/log_in_screen/log_in_screen_event.dart';
import 'business_logic/log_in_screen/log_in_screen_state.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login Successful! Welcome ${state.role}'),
                ),
              );
              // Navigate to Dashboard and remove the login screen from the stack
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()),
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 450.h, child: _buildLoginForm(context)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                  child: RichText(
                    text: TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontSources.interRegular,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontSources.interRegular,
                                  color: ColorSources.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontSources.interRegular,
                                color: Colors.black),
                          ),
                          TextSpan(
                              text: '\nPrivacy Policy',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontSources.interRegular,
                                  color: ColorSources.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontSources.interRegular,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorSources.primaryColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String input = _emailController.text;
                            String password = _passwordController.text;

                            // Simple regular expression for validating email and phone number
                            RegExp emailRegExp = RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                            RegExp phoneRegExp = RegExp(
                                r"^\d{10}$"); // Adjust for your region's phone number format

                            if (emailRegExp.hasMatch(input)) {
                              // If input is an email, call the API with email
                              // Trigger login event
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                    email: input, password: password),
                              );
                            } else if (phoneRegExp.hasMatch(input)) {
                              // If input is a phone number, call the API with phone
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                    phone: int.parse(input),
                                    password: password),
                              );
                            } else {
                              // Handle invalid input
                              if (kDebugMode) {
                                print('Invalid email or phone number');
                              }
                            }
                          }
                        },
                        child: SizedBox(
                          height: 40.h,
                          width: 250.w,
                          child: state is LoginLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              : Center(
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: FontSources.interSemiBold),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back.',
            style: TextStyle(fontSize: 32.sp, fontFamily: 'Inter-Bold'),
          ),
          Text(
            'Log in to your account',
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Inter-Regular',
                color: Colors.black),
          ),
          SizedBox(height: 20.h),
          // Email or phone TextFormField
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email or phone number';
                }
                final emailRegex =
                    RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                final phoneRegex = RegExp(r'^[0-9]{10}$');
                if (!emailRegex.hasMatch(value) &&
                    !phoneRegex.hasMatch(value)) {
                  return 'Please enter a valid email or phone number';
                }
                return null;
              },
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email / Mobile Number',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
              ),
            ),
          ),
          // Password TextFormField
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
                }
                return null;
              },
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
