import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/custom_icons_icons.dart';
import 'package:rcc_project/screens/admin/admin_home_screen/buyer_report.dart';
import 'package:rcc_project/screens/admin/admin_home_screen/collection_center.dart';
import 'package:rcc_project/screens/admin/admin_home_screen/customer_report.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminState();
}

class _AdminState extends State<AdminHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [CustomerReport(), buyerReport(), collectionCenter()];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: bglight,
          body: screens[currentIndex],
          appBar: AppBar(
              title: Text("Home"),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.logout))
              ]),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: bglight,
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.customer),
                  label: "Customer",
                  backgroundColor: bglight),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.buyer),
                  label: "Buyer",
                  backgroundColor: bglight),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box),
                  label: "Collection Center",
                  backgroundColor: bglight),
            ],
          )),
    );
  }
}
