import 'package:egg_factory/presentations/business_logic/otp_verification_screen/otp_verification_screen_bloc.dart';
import 'package:egg_factory/routes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/resources.dart';

class OtpVerificationScreen extends StatefulWidget {
  final int phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpVerificationController =
      TextEditingController();

  @override
  void dispose() {
    _otpVerificationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Dispatch the event to fetch sellers when the widget is initialized
    context
        .read<OtpVerificationScreenBloc>()
        .add(SendOTPEvent(phone: widget.phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22.w,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Change number',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontSources.interMedium,
                  color: ColorSources.primaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: BlocListener<OtpVerificationScreenBloc,
                    OtpVerificationScreenState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is OtpVerificationSuccess) {
                      if (state.message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Otp Verified Successfully'),
                          ),
                        );
                        Navigator.pushNamed(context, bottomNavigationScreen);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Otp Verification Failed, Please enter the valid OTP.'),
                          ),
                        );
                      }
                    } else if (state is OtpVerificationFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          'Enter authentication code',
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: FontSources.interBold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Enter the 4-digit that we have sent via the \nphone number ',
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: FontSources.interRegular),
                            children: [
                              TextSpan(
                                  text: "${widget.phoneNumber}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: FontSources.interBold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: PinCodeTextField(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontFamily: FontSources.interRegular),
                            controller: _otpVerificationController,
                            appContext: context,
                            length: 4,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldHeight: 48,
                              fieldWidth: 48,
                              inactiveColor: Colors.grey,
                              activeColor: Colors.grey,
                              selectedColor: ColorSources.primaryColor,
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            enableActiveFill: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(height: 150),
                        BlocBuilder<OtpVerificationScreenBloc,
                            OtpVerificationScreenState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<OtpVerificationScreenBloc>(
                                          context)
                                      .add(
                                    ContinueButtonPressed(
                                        phone: widget.phoneNumber,
                                        otp: int.parse(
                                            _otpVerificationController.text)),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorSources.primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(340, 55),
                              ),
                              child: state is OtpVerificationLoading
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
                                            fontFamily:
                                                FontSources.interRegular),
                                      ),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Resend code',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontSources.interMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
