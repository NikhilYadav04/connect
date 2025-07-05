import 'package:connect/core/constants/fontfamily.dart';
import 'package:connect/view/home/widgets/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem {
  final String title;
  final String svgPath;
  final Color textColor;
  final Color bgColor;

  CategoryItem({
    required this.title,
    required this.svgPath,
    required this.textColor,
    required this.bgColor,
  });
}

class CategorySlider extends StatelessWidget {
  final String label;
  final List<CategoryItem> items;
  final double sh;
  final double sw;

  const CategorySlider({
    super.key,
    required this.label,
    required this.items,
    required this.sh,
    required this.sw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: sw * 0.038, vertical: sh * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label1(sh, label, Colors.black, sh * 0.024),
          const SizedBox(height: 22),
          SizedBox(
            height: sh * 0.11,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  width: sw * 0.225,
                  margin: EdgeInsets.only(right: sw * 0.035, bottom: sh*0.015),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: item.bgColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        item.svgPath,
                        height: sh * 0.035,
                        width: sw * 0.035,
                      ),
                      SizedBox(height: sw * 0.01),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: textStyle2.copyWith(
                          color: item.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: sh * 0.018,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

final List<CategoryItem> categoryItems = [
  CategoryItem(
    title: "Tech",
    svgPath: "assets/svg/tech.svg",
    textColor: Color(0xFF9B4DCC),
    bgColor: Color(0xFFF3E6FF),
  ),
  CategoryItem(
    title: "Legal",
    svgPath: "assets/svg/legal.svg",
    textColor: Color(0xFF2D6FE1),
    bgColor: Color(0xFFE5EEFF),
  ),
  CategoryItem(
    title: "Finance",
    svgPath: "assets/svg/finance.svg",
    textColor: Color(0xFF28A745),
    bgColor: Color(0xFFDFFFE5),
  ),
  CategoryItem(
    title: "Wellness",
    svgPath: "assets/svg/health.svg",
    textColor: Colors.orange,
    bgColor:  Color(0xFFFFF4E5),
  ),
];
