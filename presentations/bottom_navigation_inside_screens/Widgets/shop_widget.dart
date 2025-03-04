import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/shop_screen/shop_screen_event.dart';
import 'package:egg_factory/routes/route_config.dart';
import 'package:egg_factory/utils/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/shop_screen/shop_screen_state.dart';
import '../../model_classes/shop_screen_model.dart';

class ShopListsWidget extends StatefulWidget {
  const ShopListsWidget({
    super.key,
  });

  @override
  State<ShopListsWidget> createState() => _ShopListsWidgetState();
}

class _ShopListsWidgetState extends State<ShopListsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ShopScreenBloc>().add(FetchShopDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
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
                  onPressed: () {
                    Navigator.pushNamed(context, addShopsScreen);
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
            child: BlocBuilder<ShopScreenBloc, ShopScreenState>(
              builder: (context, state) {
                if (state is ShopLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShopSuccess) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.shopData.data?.length,
                    itemBuilder: (context, index) {
                      List<ShopData>? shopData = state.shopData.data;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Container(
                          height: 105.h,
                          width: 323.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1.w),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      shopData?[index].name ?? "",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: FontSources.interBold,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.phone,
                                      size: 13,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      shopData?[index].vehicleId ?? "",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: FontSources.interRegular,
                                      ),
                                    ),
                                    // Edit button
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  shopData?[index].locationId ?? "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: FontSources.interRegular,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      shopData?[index].name ?? "",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: FontSources.interRegular),
                                    ),
                                    SizedBox(width: 5.w),
                                    const Icon(
                                      Icons.location_on,
                                      size: 15,
                                      color: ColorSources.primaryColor,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      shopData?[index].vehicleId ?? "",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: FontSources.interRegular),
                                    ),
                                    SizedBox(width: 5.w),
                                    const Icon(
                                      Icons.tram_outlined,
                                      size: 15,
                                      color: ColorSources.primaryColor,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      shopData?[index].shopId ?? "",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: FontSources.interRegular),
                                    ),
                                    const Spacer(),
                                    Row(
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
                                            context.read<ShopScreenBloc>().add(
                                                DeleteShopEvent(
                                                    shopId: state
                                                            .shopData
                                                            .data?[index]
                                                            .shopId ??
                                                        ""));
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ShopFailure) {
                  return Center(child: Text(state.message));
                } else {
                  return Text('No Data Found');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
