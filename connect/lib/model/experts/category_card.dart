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
    tagline: 'Learn from the industry best',
  ),
  Category(
    icon: Icons.attach_money,
    title: 'Finance & Investment',
    tagline: 'Grow and protect your wealth',
  ),
  Category(
    icon: Icons.gavel,
    title: 'Legal & Compliance',
    tagline: 'Get trusted expert advice today',
  ),
  Category(
    icon: Icons.fastfood,
    title: 'Diet &\nNutrition',
    tagline: 'Eat smart and live well',
  ),
  Category(
    icon: Icons.medical_services,
    title: 'Medical & HealthCare',
    tagline: 'Stay healthy every single day',
  ),
  Category(
    icon: Icons.auto_awesome,
    title: 'Astrology',
    tagline: 'Find answers in the stars',
  ),
  Category(
    icon: Icons.favorite,
    title: 'Life & \nRelationship',
    tagline: 'Build strong and lasting bonds',
  ),
  Category(
    icon: Icons.developer_mode,
    title: 'Tech &\nProduct',
    tagline: 'Innovate faster with expert help',
  ),
  Category(
    icon: Icons.home,
    title: 'Real Estate & Property',
    tagline: 'Find your dream home today',
  ),
];
