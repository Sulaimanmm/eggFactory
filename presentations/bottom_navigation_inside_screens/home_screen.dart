import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/route_config.dart';
import '../../utils/resources.dart';
import '../business_logic/home_screen/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedItem; // To store the selected dropdown item
  final GlobalKey _buttonKey = GlobalKey(); // Global key for the button
  OverlayEntry? _overlayEntry; // To store the dropdown overlay entry
  bool isDropdownOpen = false; // Track if dropdown is open

  @override
  void initState() {
    super.initState();
    // Dispatch the API call event only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenBloc>().add(FetchDealerEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 97.h,
              width: 393.w,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹ 12,100',
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: FontSources.interBold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Text(
                            '300 trays loaded',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: FontSources.interRegular,
                                color: Colors.grey),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.arrow_upward,
                            size: 15.h,
                            weight: 10,
                            color: Colors.green,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            '29.03 %',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: FontSources.interBold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: SizedBox(
                      width: 100.w,
                      height: 55.h,
                      child: Image.asset(
                        ImageSource.graphImage,
                        width: 40.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                key: _buttonKey, // Attach the key to the button

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(361.w, 42.h),
                ),
                onPressed: () {
                  // Show dropdown menu on button press
                  if (isDropdownOpen) {
                    _closeDropdown();
                  } else {
                    _showDropdownMenu();
                  }
                },
                child: Row(
                  children: [
                    Image.asset(
                      IconSource.alarmIcon, // Path to your image asset
                      width: 20,
                      height: 20,
                      color: Colors
                          .black, // Optional: Apply color filter if needed
                    ),
                    const SizedBox(width: 8), // Space between image and text
                    const Text(
                      'Tray',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ), // Text
                    Spacer(),
                    const Icon(Icons.arrow_drop_down,
                        color: Colors
                            .black), // Space between text and dropdown button
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // Function to show dropdown menu
  void _showDropdownMenu() {
    final RenderBox button =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset buttonPosition =
        button.localToGlobal(Offset.zero, ancestor: overlay);
    final Size buttonSize = button.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: buttonPosition.dx,
        top: buttonPosition.dy + buttonSize.height,
        width: buttonSize.width, // Full width of the button
        child: Material(
          elevation: 2.0,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem('Option 1'),
                _buildMenuItem('Option 2'),
                _buildMenuItem('Option 3'),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    setState(() {
      isDropdownOpen = false;
    });
  }

  Widget _buildMenuItem(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = option; // Handle selection
        });
        _closeDropdown();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(option, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
