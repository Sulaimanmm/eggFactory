import 'package:flutter/material.dart';

class UnloadedWidget extends StatefulWidget {
  const UnloadedWidget({super.key});

  @override
  State<UnloadedWidget> createState() => _UnloadedWidgetState();
}

class _UnloadedWidgetState extends State<UnloadedWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with actual count
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reliance Store",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("10 Trays Unloaded"),
                    Text("₹10,000",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("14 Aug 2023 09:44 AM",
                        style: TextStyle(color: Colors.grey)),
                    Text("₹30,000", style: TextStyle(color: Colors.green)),
                    Text("₹15,000", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
