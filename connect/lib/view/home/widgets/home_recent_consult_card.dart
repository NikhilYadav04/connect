// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connect/core/constants/fontfamily.dart';
import 'package:flutter/material.dart';

class HomeRecentConsultCard extends StatelessWidget {
  final double sh;
  final double sw;

  // New parameters for dynamic content
  final String name;
  final String subtitle;
  final double rate;

  final String profileImageUrl;

  const HomeRecentConsultCard({
    Key? key,
    required this.sh,
    required this.sw,
    required this.name,
    required this.subtitle,
    required this.rate,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding:
            EdgeInsets.symmetric(horizontal: sw * 0.038, vertical: sh * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Profile Image
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5, right: sw*0.029),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    profileImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //* Name, Subtitle, Rating, Rate
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: textStyle2.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: sh * 0.0225,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          subtitle,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle2.copyWith(
                            letterSpacing: 0.5,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: sh * 0.018,
                          ),
                        ),
                         SizedBox(height: 8),
                         Text(
                          "1 Week Ago",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle2.copyWith(
                            letterSpacing: 0.5,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: sh * 0.016,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$rate',
                        style: textStyle2.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sh * 0.022,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: sh * 0.022,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


                      // Row(
                      //   children: [
                      //     Row(
                      //       children: List.generate(
                      //         5,
                      //         (index) => Icon(
                      //           Icons.star,
                      //           color: Colors.amber,
                      //           size: sh * 0.022,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 6),
                      //     Text(
                      //       '',
                      //       style: textStyle2.copyWith(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: sh * 0.015,
                      //         color: Colors.black54,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 15),
