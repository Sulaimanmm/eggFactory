import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_event.dart';
import 'package:egg_factory/presentations/business_logic/seller_screen/seller_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/route_config.dart';
import '../../../utils/resources.dart';
import '../../model_classes/seller_screen_model.dart';

class SellerListsWidget extends StatefulWidget {
  const SellerListsWidget({
    super.key,
  });

  @override
  State<SellerListsWidget> createState() => _SellerListsWidgetState();
}

class _SellerListsWidgetState extends State<SellerListsWidget> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch sellers when the widget is initialized
    context.read<SellerScreenBloc>().add(FetchSellersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: ColorSources.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () async {
                    // Capture the BLoC reference before the async operation
                    final sellerScreenBloc = context.read<SellerScreenBloc>();

                    // Navigate to the AddSellerScreen and wait for the result
                    final result =
                        await Navigator.pushNamed(context, addSellerScreen);

                    // If an update occurred, refresh the seller list
                    if (result == true) {
                      sellerScreenBloc.add(FetchSellersEvent());
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: BlocConsumer<SellerScreenBloc, SellerScreenState>(
              listener: (context, state) {
                if (state is DeleteSellerSuccess) {
                  // Show a success message (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Seller deleted successfully!')),
                  );

                  // Refresh the seller list
                  context.read<SellerScreenBloc>().add(FetchSellersEvent());
                }

                if (state is SellerFailure) {
                  // Handle failure case (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is SellerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchSellerSuccess) {
                  // Check if the data list is empty
                  if (state.sellerData.data.isEmpty) {
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: FontSources.interBold,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.sellerData.data.length,
                    itemBuilder: (context, index) {
                      List<SellerInfo> sellerData = state.sellerData.data;
                      return Container(
                        height: 61.h,
                        width: 323.w,
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sellerData[index].name,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: FontSources.interBold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                        size: 13,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        sellerData[index].phone.toString(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily:
                                                FontSources.interRegular),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 17.h),
                                child: Text(
                                  sellerData[index].vehicleNo,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: FontSources.interRegular),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              // Edit button

                              Padding(
                                padding: EdgeInsets.only(bottom: 17.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      height: 20.h,
                                      width: 1.w,
                                    ),
                                    // Delete button
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        context.read<SellerScreenBloc>().add(
                                            DeleteSellerEvent(
                                                vehicleId: state.sellerData
                                                    .data[index].vehicleId));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is SellerFailure) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox(
                    child: Center(
                      child: Text("No Data Found"),
                    ),
                  ); // Handle other states, if any.
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
