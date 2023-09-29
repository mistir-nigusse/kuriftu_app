import 'package:flutter/material.dart';
import 'package:kuriftu_app/view/screens/Bookings/booking_list.dart';
import 'package:kuriftu_app/view/screens/packages_view/packages_list.dart';

class Custom_tabs extends StatefulWidget {
  @override
  Custom_tabsState createState() => Custom_tabsState();
}

class Custom_tabsState extends State<Custom_tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          // construct the profile details widget here

          // the tab bar with two items
          SizedBox(
            height: 50,
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "All Packages",
                  ),
                  Tab(
                    text: "Booked Packages",
                  ),
                ],
              ),
            ),
          ),

          // create widgets for each tab bar here
          Expanded(
            child: TabBarView(
              children: [
                // first tab bar view widget
                PackagesList(),
                // Container(
                //   color: Colors.white60,
                //   child: Center(
                //     child: Text(
                //       'tab 1 Comming soon...',
                //     ),

                // second tab bar viiew widget
                BookingList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
