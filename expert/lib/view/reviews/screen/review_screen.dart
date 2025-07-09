import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:expert/model/review/model_recent_review.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  static const int _initialCount = 20;
  static const int _expandedCount = 50;
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    // *Jakarta font helpers
    TextStyle light(double size, [Color? color]) => TextStyle(
          fontFamily: 'Jakarta-Light',
          fontSize: size,
          color: color ?? Colors.black,
        );
    TextStyle medium(double size, [Color? color]) => TextStyle(
          fontFamily: 'Jakarta-Medium',
          fontSize: size,
          color: color ?? Colors.black,
        );
    TextStyle bold(double size, [Color? color]) => TextStyle(
          fontFamily: 'Jakarta-Bold',
          fontSize: size,
          color: color ?? Colors.black,
        );

    //* Determine how many to show
    final count = _showMore
        ? (_expandedCount <= recentReviews.length
            ? _expandedCount
            : recentReviews.length)
        : (_initialCount <= recentReviews.length
            ? _initialCount
            : recentReviews.length);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorLightGrayBG,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: sh * 0.074,
          backgroundColor: AppColors.colorPurple,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sh * 0.02),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Recent Reviews",
                        style: textStyle2.copyWith(
                          wordSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: sh * 0.027,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.01),
          child: Column(
            children: [
              SizedBox(height: sh * 0.01),
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, i) {
                    final r = recentReviews[i];
                    return Container(
                      margin: EdgeInsets.only(bottom: sh * 0.02),
                      padding: EdgeInsets.all(sw * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  r.author,
                                  style: textStyle3.copyWith(
                                      fontSize: sh * 0.022,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade900),
                                ),
                              ),
                              Row(
                                children: List.generate(5, (j) {
                                  IconData icon;
                                  if (j < r.rating.floor()) {
                                    icon = Icons.star;
                                  } else if (j < r.rating) {
                                    icon = Icons.star_half;
                                  } else {
                                    icon = Icons.star_border;
                                  }
                                  return Icon(
                                    icon,
                                    size: sh * 0.022,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                              SizedBox(width: sw * 0.02),
                              Text(
                                '${r.date.year}-${r.date.month.toString().padLeft(2, '0')}-${r.date.day.toString().padLeft(2, '0')}',
                                style: light(sh * 0.017, Colors.grey[600]),
                              ),
                            ],
                          ),
                          SizedBox(height: sh * 0.012),
                          Text(
                            r.comment,
                            style: medium(sh * 0.019),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //* Toggle button with icon
              if (recentReviews.length > _initialCount)
                Padding(
                  padding: EdgeInsets.only(top: sh * 0.005),
                  child: TextButton(
                    onPressed: () => setState(() => _showMore = !_showMore),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _showMore ? 'View Less' : 'View More',
                          style: textStyle3.copyWith(
                            fontSize: sh * 0.021,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorPurple,
                          ),
                        ),
                        SizedBox(width: sw * 0.01),
                        Icon(
                          _showMore
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.colorPurple,
                          size: sh * 0.032,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
