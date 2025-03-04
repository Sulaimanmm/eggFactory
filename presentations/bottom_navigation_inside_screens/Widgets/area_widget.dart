import 'package:egg_factory/presentations/business_logic/area_screen/area_screen_bloc.dart';
import 'package:egg_factory/routes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/resources.dart';
import '../../model_classes/area_screen_model.dart';

class AreaListsWidget extends StatefulWidget {
  const AreaListsWidget({
    super.key,
  });

  @override
  State<AreaListsWidget> createState() => _AreaListsWidgetState();
}

class _AreaListsWidgetState extends State<AreaListsWidget> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch sellers when the widget is initialized
    context.read<AreaScreenBloc>().add(FetchAreaDataEvent());
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
                    final areaScreenBloc = context.read<AreaScreenBloc>();

                    // Navigate to the addAreaScreen and wait for the result
                    final result =
                        await Navigator.pushNamed(context, addAreaScreen);

                    // If an update occurred, refresh the seller list
                    if (result == true) {
                      areaScreenBloc.add(FetchAreaDataEvent());
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
          SizedBox(height: 10.h),
          Expanded(
            child: BlocConsumer<AreaScreenBloc, AreaScreenState>(
              listener: (context, state) {
                if (state is DeleteAreaSuccess) {
                  // Show a success message (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Seller deleted successfully!')),
                  );

                  // Refresh the seller list
                  context.read<AreaScreenBloc>().add(FetchAreaDataEvent());
                }

                if (state is AreaScreenFailure) {
                  // Handle failure case (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AreaScreenLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchAreaSuccess) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.areaData.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      List<AreaInfo>? areaData = state.areaData.data;
                      return Container(
                        height: 46.h,
                        width: 323.w,
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.w),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  areaData?[index].name ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  areaData?[index].zipcode.toString() ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: FontSources.interMedium,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                // Edit button
                                SizedBox(
                                  height: 30.h,
                                  width: 90.w,
                                  child: Align(
                                    alignment: Alignment.center,
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
                                            context.read<AreaScreenBloc>().add(
                                                  DeleteAreaEvent(
                                                      areaId: state
                                                              .areaData
                                                              .data?[index]
                                                              .locationId ??
                                                          ""),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AreaScreenFailure) {
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
