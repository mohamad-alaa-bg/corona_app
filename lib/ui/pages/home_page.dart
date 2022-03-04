import 'package:corona_app/res/colors/app_colors.dart';
import 'package:corona_app/ui/pages/corona_countries.dart';
import 'package:corona_app/ui/pages/corona_summary_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.darkBk,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all),
            label: "Summary",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: "Countries",
          ),
        ],
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        unselectedItemColor: Colors.grey[700],
      ),
      body: IndexedStack(
        children: [
          CoronaSummaryPage(),
          CoronaCountriesPage(),
        ],
        index: currentTab,
      ),
    );
  }
}
