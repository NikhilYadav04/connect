import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String title;
  final String tagline;

  Category({
    required this.icon,
    required this.title,
    required this.tagline,
  });
}

//* Your category data
final List<Category> categories = [
  Category(
    icon: Icons.school,
    title: 'Mentoring',
    tagline: 'Learn from the best',
  ),
  Category(
    icon: Icons.attach_money,
    title: 'Finance & Investment',
    tagline: 'Grow your wealth',
  ),
  Category(
    icon: Icons.gavel,
    title: 'Legal & Compliance',
    tagline: 'Get expert advice',
  ),
  Category(
    icon: Icons.fastfood,
    title: 'Diet & Nutrition',
    tagline: 'Eat smart, live well',
  ),
  Category(
    icon: Icons.medical_services,
    title: 'Medical & HealthCare',
    tagline: 'Stay healthy',
  ),
  Category(
    icon: Icons.auto_awesome,
    title: 'Astrology',
    tagline: 'Stars have answers',
  ),
  Category(
    icon: Icons.favorite,
    title: 'Life & Relationship',
    tagline: 'Build strong bonds',
  ),
  Category(
    icon: Icons.developer_mode,
    title: 'Tech & Product',
    tagline: 'Innovate faster',
  ),
  Category(
    icon: Icons.home,
    title: 'Real Estate & Property',
    tagline: 'Find your dream home',
  ),
];
