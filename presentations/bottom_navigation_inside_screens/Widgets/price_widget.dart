import 'package:egg_factory/utils/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceListsWidget extends StatefulWidget {
  const PriceListsWidget({
    super.key,
    required this.priceData,
  });

  final List<Map<String, String>> priceData;

  @override
  State<PriceListsWidget> createState() => _PriceListsWidgetState();
}

class _PriceListsWidgetState extends State<PriceListsWidget> {
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
                  onPressed: () {
                    if (kDebugMode) {
                      print("Add button clicked");
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
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.priceData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Container(
                    height: 58.h,
                    width: 353.w,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.w),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.priceData[index]['price']!,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '1200',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: FontSources.interRegular),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
