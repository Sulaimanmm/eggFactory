import 'package:egg_factory/presentations/business_logic/load_screen/load_screen_bloc.dart';
import 'package:egg_factory/presentations/model_classes/load_screen_model.dart';
import 'package:egg_factory/routes/route_config.dart';
import 'package:egg_factory/utils/auth_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/resources.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  String? userName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LoadScreenBloc>(context).add(FetchLoadEvent());
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    UserDetailsStorage userDetailsStorage = UserDetailsStorage();
    String? name = await userDetailsStorage.getName();
    setState(() {
      userName = name ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const ImageIcon(
                color: ColorSources.primaryColor,
                AssetImage(IconSource.sideDrawerIcon),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const ImageIcon(
              color: ColorSources.primaryColor,
              AssetImage(IconSource.langIcon),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          IconButton(
            icon: const ImageIcon(
              color: ColorSources.primaryColor,
              AssetImage(IconSource.profileIcon),
            ),
            onPressed: () {
              Navigator.pushNamed(context, profileScreen);
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42.h,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
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
                    height: 42.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                        color: ColorSources.primaryColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                  height: 460.h,
                  child: BlocBuilder<LoadScreenBloc, LoadScreenState>(
                      builder: (context, state) {
                    final UserDetailsStorage userDetailsStorage;
                    if (state is LoadLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadSuccess) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, loadViewScreen);
                        },
                        child: ListView.builder(
                          itemCount: state.loadedData.data.length,
                          itemBuilder: (context, index) {
                            LoadData loadData = state.loadedData.data[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 85.h,
                                width: 353.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 0.5.w),
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            userName ?? "No Name",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily:
                                                  FontSources.interMedium,
                                            ),
                                          ),
                                          Text(
                                            loadData.totalAmount.toString(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily:
                                                  FontSources.interMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${loadData.totalCount} Trays Loaded',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily:
                                                  FontSources.interRegular,
                                            ),
                                          ),
                                          Text(
                                            loadData.loadDate,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily:
                                                  FontSources.interRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),

                                      SizedBox(
                                        height: 16.h,
                                        width: 285.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r)),
                                              child: Center(
                                                child: Text(
                                                  "Status",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: FontSources
                                                        .interRegular,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  IconSource.unLoadedIcon,
                                                  height: 10.h,
                                                  width: 10.w,
                                                ),
                                                SizedBox(width: 3.w),
                                                Text(
                                                  '0 Unloaded',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily: FontSources
                                                        .interRegular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  IconSource.damageIcon,
                                                  height: 10.h,
                                                  width: 10.w,
                                                ),
                                                SizedBox(width: 3.w),
                                                Text(
                                                  '10 Damaged',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily: FontSources
                                                        .interRegular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Edit button
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is LoadFailure) {
                      return Center(child: Text(state.message));
                    }
                    return Center(
                      child: Text('NO Data Found'),
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
