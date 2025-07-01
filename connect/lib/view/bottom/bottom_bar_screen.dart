import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';
import 'package:connect/model/bottom_bar/model_bottom_bar.dart';
import 'package:connect/view/home/screen/home_screen.dart';
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
    HomeScreen(),
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Add Screen', style: TextStyle(fontSize: 24))),
   
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
        height: sh * 0.095,
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
            iconSize: sh * 0.038,
            unselectedItemColor: Colors.grey.shade700,
            unselectedLabelStyle: textStyle3.copyWith(
              color: Colors.black,
              fontSize: sh * 0.017,
              fontWeight: FontWeight.bold,
            ),
            selectedLabelStyle: textStyle3.copyWith(
              color: AppColors.colorPurple,
              fontSize: sh * 0.017,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            items:
                bottomItems, // Assuming bottomItems is a List<BottomNavigationBarItem>
          ),
        ),
      ),
    );
  }
}
