import 'package:egg_factory/presentations/business_logic/area_screen/area_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_state.dart';
import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_event.dart';
import 'package:egg_factory/presentations/model_classes/area_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/auth_preference.dart';
import '../../utils/resources.dart';
import '../business_logic/seller_screen/seller_screen_bloc.dart';
import '../business_logic/seller_screen/seller_screen_event.dart';
import '../model_classes/seller_screen_model.dart';

class AddShopScreen extends StatefulWidget {
  const AddShopScreen({super.key});

  @override
  State<AddShopScreen> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  final bool _isActive = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  SellerInfo? _selectedSeller; // Variable to hold selected value
  AreaInfo? _selectedArea; // Variable to hold selected value

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SellerScreenBloc>().add(FetchSellersEvent());
    context.read<AreaScreenBloc>().add(FetchAreaDataEvent());
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
          'Add Shop',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: Column(
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Shop Name',
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
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
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
                      BlocBuilder<AreaScreenBloc, AreaScreenState>(
                        builder: (context, state) {
                          if (state is AreaScreenLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is FetchAreaSuccess) {
                            return DropdownButtonFormField<AreaInfo>(
                              hint: Text('Select Area*'),
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
                              items: state.areaData.data?.map((AreaInfo area) {
                                return DropdownMenuItem<AreaInfo>(
                                  value: area,
                                  child: Text(area.name ?? ""),
                                );
                              }).toList(),
                              onChanged: (AreaInfo? newValue) {
                                setState(() {
                                  _selectedArea =
                                      newValue; // Update the selected seller
                                });
                              },
                              value:
                                  _selectedArea, // Set the currently selected value
                            );
                          } else {
                            return Center(child: Text("Error"));
                          }
                        },
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Status toggle field

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 40.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String address = _addressController.text;
                    int phone = int.parse(_phoneController.text);
                    String sellerId = _selectedSeller?.vehicleId ?? "";
                    String locationId = _selectedArea?.locationId ?? "";
                    bool isActive = _isActive;
                    // Capture the BLoC reference before the async operation
                    final shopScreenBloc = context.read<ShopScreenBloc>();
                    // Perform async operation after capturing the context-dependent values
                    final dealerId = await TokenStorage().getDealerId();

                    // Call the BLoC event to add a shop after the async operation
                    shopScreenBloc.add(
                      AddShopEvent(
                        name: name,
                        address: address,
                        phone: phone,
                        sellerId: sellerId,
                        locationId: locationId,
                        dealerId: dealerId ?? "",
                        credit: 0,
                        trayBalance: '0',
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorSources
                      .primaryColor, // Set your desired button color here
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
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
