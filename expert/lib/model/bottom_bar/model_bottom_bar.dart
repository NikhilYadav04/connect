import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.analytics_outlined),
    activeIcon: Icon(Icons.analytics),
    label: 'Analytics',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.schedule_outlined),
    activeIcon: Icon(Icons.schedule),
    label: 'Sessions',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.rate_review_outlined),
    activeIcon: Icon(Icons.rate_review),
    label: 'Reviews',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];
