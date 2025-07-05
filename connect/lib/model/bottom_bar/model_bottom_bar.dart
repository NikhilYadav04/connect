import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.school),
    activeIcon: Icon(Icons.school),
    label: 'Experts',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.help_outline),
    activeIcon: Icon(Icons.help_outline),
    label: "FAQ's",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];
