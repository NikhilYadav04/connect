// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String title;
  final String titleMain;
  final String tagline;

  Category({
    required this.icon,
    required this.title,
    required this.titleMain,
    required this.tagline,
  });
}

//* Your category data
final List<Category> categories = [
  Category(
    icon: Icons.school,
    title: 'Mentoring',
    titleMain: 'Mentoring',
    tagline: 'Learn from the industry best',
  ),
  Category(
    icon: Icons.attach_money,
    title: 'Finance &\nInvestment',
    titleMain: 'Finance & Investment',
    tagline: 'Grow and protect your wealth',
  ),
  Category(
    icon: Icons.gavel,
    title: 'Legal &\nCompliance',
    titleMain: 'Legal & Compliance',
    tagline: 'Get trusted expert advice today',
  ),
  Category(
    icon: Icons.fastfood,
    title: 'Diet &\nNutrition',
    titleMain: 'Diet & Nutrition',
    tagline: 'Eat smart and live well',
  ),
  Category(
    icon: Icons.medical_services,
    title: 'Medical &\nHealthCare',
    titleMain: 'Medical & HealthCare',
    tagline: 'Stay healthy every single day',
  ),
  Category(
    icon: Icons.auto_awesome,
    title: 'Astrology',
    titleMain: 'Astrology',
    tagline: 'Find answers in the stars',
  ),
  Category(
    icon: Icons.favorite,
    title: 'Life &\nRelationship',
    titleMain: 'Life & Relationship',
    tagline: 'Build strong and lasting bonds',
  ),
  Category(
    icon: Icons.developer_mode,
    title: 'Tech &\nProduct',
    titleMain: 'Tech & Product',
    tagline: 'Innovate faster with expert help',
  ),
  Category(
    icon: Icons.home,
    title: 'Real Estate &\nProperty',
    titleMain: 'Real Estate & Property',
    tagline: 'Find your dream home today',
  ),
];
