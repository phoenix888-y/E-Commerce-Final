import 'package:ecommerce_outlet_app_565/Services/firebase_services.dart';
import 'package:ecommerce_outlet_app_565/constants.dart';
import 'package:ecommerce_outlet_app_565/tabs/filter_tab.dart';
import 'package:ecommerce_outlet_app_565/tabs/product_tab.dart';
import 'package:ecommerce_outlet_app_565/widgets/bottom_tab.dart';
import 'package:ecommerce_outlet_app_565/tabs/home_tab.dart';
import 'package:ecommerce_outlet_app_565/tabs/search_tab.dart';
import 'package:ecommerce_outlet_app_565/tabs/saved_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                  print("num -> 47");
                  print(num);
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                //SaveTab(),
                ProductTab(),
                FilterTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
