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

    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Reviews', style: bold(sw * 0.05, Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: sw * 0.04, vertical: sh * 0.02),
        child: Column(
          children: [
            //* Reviews list
            Expanded(
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, i) {
                  final r = recentReviews[i];
                  return Container(
                    margin: EdgeInsets.only(bottom: sh * 0.015),
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(r.author, style: bold(sw * 0.045)),
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
                                return Icon(icon,
                                    size: sw * 0.045, color: Colors.amber);
                              }),
                            ),
                            SizedBox(width: sw * 0.02),
                            Text(
                              '${r.date.year}-${r.date.month.toString().padLeft(2, '0')}-${r.date.day.toString().padLeft(2, '0')}',
                              style: light(sw * 0.035, Colors.grey[600]),
                            ),
                          ],
                        ),
                        SizedBox(height: sh * 0.01),
                        Text(r.comment, style: medium(sw * 0.04)),
                      ],
                    ),
                  );
                },
              ),
            ),
            //* Toggle button
            if (recentReviews.length > _initialCount)
              TextButton(
                onPressed: () => setState(() => _showMore = !_showMore),
                child: Text(
                  _showMore ? 'View Less' : 'View More',
                  style: medium(sw * 0.045, Colors.blueAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}