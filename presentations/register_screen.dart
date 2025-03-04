import 'package:egg_factory/presentations/business_logic/register_screen/register_screen_bloc.dart';
import 'package:egg_factory/routes/route_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/resources.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          'Create Account',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontSources.interRegular,
              color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocListener<RegisterScreenBloc, RegisterScreenState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is RegisterSuccess) {
                        if (state.registerData.statusCode == 201) {
                          Navigator.pushNamed(context, otpVerificationScreen,
                              arguments: state.registerData.data?.phone ?? 0);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration Failed!'),
                            ),
                          );
                        }
                      } else if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email or phone number';
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                                final phoneRegex = RegExp(r'^[0-9]{10}$');
                                if (!emailRegex.hasMatch(value) &&
                                    !phoneRegex.hasMatch(value)) {
                                  return 'Please enter a valid email or phone number';
                                }
                                return null;
                              },
                              controller: _emailIdController,
                              decoration: InputDecoration(
                                labelText: 'Email / Mobile Number',
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.blue,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: TextFormField(
                              obscureText:
                                  !_isPasswordVisible, // Add obscureText for secure input
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the password';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.blue,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: TextFormField(
                              obscureText:
                                  !_isConfirmPasswordVisible, // Add obscureText for secure input
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.blue,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 10.w),
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
                                            fontFamily:
                                                FontSources.interRegular,
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
                                            fontFamily:
                                                FontSources.interRegular,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              child: BlocBuilder<RegisterScreenBloc, RegisterScreenState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        String input = _emailIdController.text;
                        String password = _passwordController.text;

                        // Simple regular expression for validating email and phone number
                        RegExp emailRegExp = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                        RegExp phoneRegExp = RegExp(
                            r"^\d{10}$"); // Adjust for your region's phone number format

                        if (emailRegExp.hasMatch(input)) {
                          // If input is an email, call the API with email
                          // Trigger login event
                          BlocProvider.of<RegisterScreenBloc>(context).add(
                            RegisterButtonPressed(
                                email: input, password: password),
                          );
                        } else if (phoneRegExp.hasMatch(input)) {
                          // If input is a phone number, call the API with phone
                          BlocProvider.of<RegisterScreenBloc>(context).add(
                            RegisterButtonPressed(
                                phone: int.parse(input), password: password),
                          );
                        } else {
                          // Handle invalid input
                          if (kDebugMode) {
                            print('Invalid email or phone number');
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSources.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(280.w, 40.h),
                    ),
                    child: state is RegisterLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: FontSources.interRegular),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
