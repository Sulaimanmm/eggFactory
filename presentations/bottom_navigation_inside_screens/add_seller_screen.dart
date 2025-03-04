import 'dart:io';

import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_event.dart';
import 'package:egg_factory/utils/auth_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'
    as picker; // Prefix for image_picker
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/resources.dart';
import '../business_logic/seller_screen/seller_screen_state.dart';

class AddSellerScreen extends StatefulWidget {
  const AddSellerScreen({super.key});

  @override
  State<AddSellerScreen> createState() => _AddSellerScreenState();
}

class _AddSellerScreenState extends State<AddSellerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _altPhoneController = TextEditingController();
  bool _isActive = false;
  File? _proofFile;

  Future<void> _uploadProof() async {
    // Request permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final imagePicker = ImagePicker();
    final pickedFile =
        await imagePicker.pickImage(source: picker.ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _proofFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _sellerNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _vehicleController.dispose();
    _altPhoneController.dispose();
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
            size: 22.sp,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add Seller',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: BlocListener<SellerScreenBloc, SellerScreenState>(
        listener: (context, state) async {
          if (state is AddSellerSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('seller added ${state.message}')),
            );
            // Add a delay before popping back
            await Future.delayed(const Duration(seconds: 4));
            // Navigate back to the seller screen on success
            Navigator.pop(context, true);
          } else if (state is SellerFailure) {
            // Optionally, you can handle failures or show error messages here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add seller')),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<SellerScreenBloc, SellerScreenState>(
                      builder: (context, state) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // Align children to stretch full width
                            children: [
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Seller Name';
                                  }
                                  return null;
                                },
                                controller: _sellerNameController,
                                decoration: InputDecoration(
                                  labelText: 'Seller Name*',
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
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Password';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password*',
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
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Phone Number';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number*',
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
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Vehicle Number';
                                  }
                                  return null;
                                },
                                controller: _vehicleController,
                                decoration: InputDecoration(
                                  labelText: 'Vehicle No*',
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
                              SizedBox(height: 20.h),
                              TextFormField(
                                controller: _altPhoneController,
                                decoration: InputDecoration(
                                  labelText: 'Alt Phone Number',
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
                              SizedBox(height: 15.h),
                              SwitchListTile(
                                title: const Text('Is Active'),
                                value: _isActive,
                                onChanged: (value) {
                                  setState(() {
                                    _isActive = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upload Proof of Sale',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  _proofFile != null
                                      ? Image.file(
                                          _proofFile!,
                                          height: 200,
                                          width: double.infinity - 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 200,
                                          width: double.infinity - 100,
                                          color: Colors.grey[300],
                                          child: Center(
                                              child: Text('No image selected')),
                                        ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: _uploadProof,
                                    child: Text('Upload Proof'),
                                  ),
                                ],
                              ),
                            ]);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorSources.primaryColor,
                  // Set your desired button color here
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontFamily: FontSources.interMedium,
                      fontSize: 17.sp,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
