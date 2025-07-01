import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    activeIcon: Icon(Icons.search),
    label: 'Explore',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.history),
    activeIcon: Icon(Icons.history),
    label: 'History',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];
