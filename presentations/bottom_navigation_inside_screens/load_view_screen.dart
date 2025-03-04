import 'package:egg_factory/presentations/business_logic/expenses_screen/expenses_screen_bloc.dart';
import 'package:egg_factory/presentations/business_logic/load_screen/load_screen_bloc.dart';
import 'package:egg_factory/utils/auth_preference.dart';
import 'package:egg_factory/utils/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LoadViewScreen extends StatefulWidget {
  const LoadViewScreen({super.key});

  @override
  State<LoadViewScreen> createState() => _LoadViewScreenState();
}

class _LoadViewScreenState extends State<LoadViewScreen> {
  int _selectedIndex = 0;
  String? userName;

  Future<void> _fetchUserName() async {
    UserDetailsStorage userDetailsStorage = UserDetailsStorage();
    String? name = await userDetailsStorage.getName();
    setState(() {
      userName = name ?? 'Guest';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserName();
    BlocProvider.of<ExpensesScreenBloc>(context).add(FetchExpenses());
    BlocProvider.of<LoadScreenBloc>(context).add(FetchLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Load View"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Grid Container
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                children: [
                  _buildSummaryCard("Amount", "₹15,000", Icons.email),
                  _buildSummaryCard("Received", "₹13,000", Icons.email),
                  _buildSummaryCard(
                      "Expenses", "₹900", Icons.account_balance_wallet),
                  _buildSummaryCard("In Hand", "₹12,100", Icons.attach_money),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.h),
          // Content based on selected button
          SizedBox(
            height: 320.h,
            child:
                _selectedIndex == 0 ? _buildLoadList() : _buildExpensesList(),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomButton("Unloaded", 0),
            _buildBottomButton("Expenses", 1)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.blue),
          ),
          SizedBox(width: 16.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
              Text(amount,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadList() {
    return BlocBuilder<LoadScreenBloc, LoadScreenState>(
      builder: (context, state) {
        if (state is LoadLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadSuccess) {
          return ListView.builder(
            itemCount:
                state.loadedData.data.length, // Replace with actual count
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName ?? "Guest",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            DateFormat('dd MMM yyyy hh:mma').format(
                                DateTime.parse(
                                    state.loadedData.data[index].loadDate ??
                                        "")),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.archive_outlined,
                            color: ColorSources.primaryColor,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                              "${state.loadedData.data[index].totalCount} Trays Unloaded"),
                          Spacer(),
                          Text("₹ ${state.loadedData.data[index].totalAmount}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("100", style: TextStyle(color: Colors.grey)),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Icon(
                                  Icons.clean_hands_sharp,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text("150", style: TextStyle(color: Colors.grey)),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Icon(
                                  Icons.more_time,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "₹ ${state.loadedData.data[index].singlePrice}",
                                  style: TextStyle(color: Colors.grey)),
                              Icon(
                                Icons.clean_hands_sharp,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                  "₹ ${state.loadedData.data[index].totalAmount - state.loadedData.data[index].singlePrice}",
                                  style: TextStyle(color: Colors.grey)),
                              Icon(
                                Icons.more_time,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildExpensesList() {
    return BlocBuilder<ExpensesScreenBloc, ExpensesScreenState>(
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpensesSuccess) {
          return ListView.builder(
            itemCount: state.expensesModel.data
                ?.length, // Replace with actual count from state
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 0.5.w, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${state.expensesModel.data?[index].description}',
                            // Replace with actual title
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            '₹ ${state.expensesModel.data?[index].spent}',
                            // Replace with actual title
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("4 Member"),
                          Spacer(),
                          Text(
                            state.expensesModel.data?[index].date != null
                                ? DateFormat('dd MMM yyyy hh:mma').format(
                                    DateTime.parse(state.expensesModel
                                            .data?[index].createdAt ??
                                        ""))
                                : 'Date not available',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildBottomButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 40.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? ColorSources.primaryColor
              : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: FontSources.interMedium,
                color: Colors.white,
                fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
