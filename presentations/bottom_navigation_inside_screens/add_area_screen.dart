import 'package:egg_factory/presentations/business_logic/area_screen/area_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_state.dart';
import 'package:egg_factory/presentations/model_classes/seller_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/auth_preference.dart';
import '../../utils/resources.dart';
import '../business_logic/seller_screen/seller_screen_event.dart';

class AddAreaScreen extends StatefulWidget {
  const AddAreaScreen({super.key});

  @override
  State<AddAreaScreen> createState() => _AddAreaScreenState();
}

class _AddAreaScreenState extends State<AddAreaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  bool _isActive = false;
  SellerInfo? _selectedSeller; // Variable to hold selected value
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch sellers when the widget is initialized
    context.read<SellerScreenBloc>().add(FetchSellersEvent());
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
          'Add Area',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: BlocListener<AreaScreenBloc, AreaScreenState>(
        listener: (context, state) async {
          // TODO: implement listener
          if (state is AddAreaSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('area added ${state.message}')),
            );
            // Add a delay before popping back
            await Future.delayed(const Duration(seconds: 4));
            // Navigate back to the seller screen on success
            Navigator.pop(context, true);
          } else if (state is AreaScreenFailure) {
            // Optionally, you can handle failures or show error messages here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add area')),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, // Align children to stretch full width
                      children: [
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: _areaController,
                          decoration: InputDecoration(
                            labelText: 'Area Name*',
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
                          controller: _pinCodeController,
                          decoration: InputDecoration(
                            labelText: 'Pincode*',
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
                        BlocBuilder<SellerScreenBloc, SellerScreenState>(
                          builder: (context, state) {
                            if (state is SellerLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is FetchSellerSuccess) {
                              return DropdownButtonFormField<SellerInfo>(
                                hint: Text('Select Seller*'),
                                dropdownColor: Colors.white,
                                // Change dropdown background color here
                                decoration: InputDecoration(
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
                                items: state.sellerData.data
                                    .map((SellerInfo seller) {
                                  return DropdownMenuItem<SellerInfo>(
                                    value: seller,
                                    child: Text(seller.vehicleNo),
                                  );
                                }).toList(),
                                onChanged: (SellerInfo? newValue) {
                                  setState(() {
                                    _selectedSeller =
                                        newValue; // Update the selected seller
                                  });
                                },
                                value:
                                    _selectedSeller, // Set the currently selected value
                              );
                            } else {
                              return Center(child: Text("Error"));
                            }
                          },
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 40.h,
                width: double.infinity,
                child: BlocBuilder<AreaScreenBloc, AreaScreenState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String name = _areaController.text;
                          int pincode = int.parse(_pinCodeController.text);
                          String sellerId = _selectedSeller?.vehicleId ?? "";

                          // Capture the BLoC reference before the async operation
                          final areaScreenBloc = context.read<AreaScreenBloc>();

                          // Perform async operation after capturing the context-dependent values
                          final dealerId = await TokenStorage().getDealerId();

                          // Call the BLoC event to add a seller after the async operation
                          areaScreenBloc.add(
                            AddAreaEvent(
                                areaName: name,
                                pincode: pincode,
                                sellerId: sellerId,
                                dealerId: dealerId ?? "",
                                isActive: _isActive),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSources
                            .primaryColor, // Set your desired button color here
                      ),
                      child: state is AreaScreenLoading
                          ? SizedBox(
                              height: 40.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Submit',
                              style: TextStyle(
                                  fontFamily: FontSources.interMedium,
                                  fontSize: 17.sp,
                                  color: Colors.white),
                            ),
                    );
                  },
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
