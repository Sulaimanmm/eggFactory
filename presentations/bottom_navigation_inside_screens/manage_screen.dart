import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/route_config.dart';
import '../../utils/resources.dart';
import 'Widgets/area_widget.dart';
import 'Widgets/price_widget.dart';
import 'Widgets/seller_widget.dart';
import 'Widgets/shop_widget.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
  }

  List<Map<String, String>> priceData = [
    {'price': 'Tray Price*'},
    {'price': 'Hen Price*'},
    {'price': 'Egg Price*'},
    {'price': 'Chicken Price*'},
  ];

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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: 510.h,
        child: TabBarView(
          controller: _tabController,
          children: [
            SellerListsWidget(),
            AreaListsWidget(),
            ShopListsWidget(),
            PriceListsWidget(priceData: priceData),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          // Indicator color
          indicatorWeight: 3.0,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorSources.primaryColor),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),

          controller: _tabController,
          tabs: const [
            Tab(text: 'Sellers'),
            Tab(text: 'Area'),
            Tab(text: 'Shops'),
            Tab(text: 'Price'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
