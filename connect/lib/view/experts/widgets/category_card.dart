// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connect/core/constants/fontfamily.dart';
import 'package:flutter/material.dart';

import 'package:connect/model/experts/category_card.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  final VoidCallback? onTap;
  final int index;
  final double height;
  final double width;

  // Predefined list of base colors for theming
  static const List<MaterialColor> _baseColors = [
    Colors.deepOrange, // 0: Mentoring
    Colors.indigo, // 1: Finance & Investment
    Colors.green, // 2: Legal & Compliance
    Colors.amber, // 3: Diet & Nutrition
    Colors.teal, // 4: Medical & HealthCare
    Colors.purple, // 5: Astrology
    Colors.pink, // 6: Life & Relationship
    Colors.blue, // 7: Tech & Product
    Colors.brown, // 8: Real Estate & Property
  ];

  const CategoryCard({
    Key? key,
    required this.category,
    this.onTap,
    required this.index,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap?.call();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = CategoryCard._baseColors[widget.index % CategoryCard._baseColors.length];
    final scale = _isPressed ? 0.95 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor.shade50, // light background
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(widget.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon circle
                Container(
                  decoration: BoxDecoration(
                    color: baseColor.shade100, // slightly darker
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(widget.height * 0.015),
                  child: Center(
                    child: Icon(
                      widget.category.icon,
                      size: widget.height * 0.04,
                      color: baseColor, // base icon color
                    ),
                  ),
                ),
                SizedBox(height: widget.height * 0.012),
                // Category title
                Center(
                  child: Text(
                    widget.category.title,
                    textAlign: TextAlign.center,
                    style: textStyle2.copyWith(
                      fontSize: widget.height * 0.02,
                      fontWeight: FontWeight.bold,
                      color: baseColor.shade800, // dark title
                    ),
                  ),
                ),
                Spacer(),
                // Tagline
                Center(
                  child: Text(
                    widget.category.tagline,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: textStyle2.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: widget.height * 0.018,
                      color: baseColor.shade600, // light tagline
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.005,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
