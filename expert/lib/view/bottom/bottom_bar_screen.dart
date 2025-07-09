import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:expert/model/bottom_bar/model_bottom_bar.dart';
import 'package:expert/view/analytics/screen/analytics_screen.dart';
import 'package:expert/view/profile/screen/profile_screen.dart';
import 'package:expert/view/reviews/screen/review_screen.dart';
import 'package:expert/view/sessions/screen/sessions_screen.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //* index for navigation
  int _currentIndex = 0;

  //* List of pages to display
  final List<Widget> _pages = [
    AnalyticsScreen(),
    SessionsScreen(),
    ReviewScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.colorLightGrayBG,

      //* Display the current page based on index
      body: _pages[_currentIndex],

      //* Bottom navigation bar
      bottomNavigationBar: SizedBox(
        height: sh * 0.085,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 20,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            iconSize: sh * 0.032,
            unselectedItemColor: Colors.grey.shade700,
            unselectedLabelStyle: textStyle3.copyWith(
              color: Colors.black,
              fontSize: sh * 0.016,
              fontWeight: FontWeight.bold,
            ),
            selectedLabelStyle: textStyle3.copyWith(
              color: AppColors.colorPurple,
              fontSize: sh * 0.016,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            items: bottomItems,
          ),
        ),
      ),
    );
  }
}
