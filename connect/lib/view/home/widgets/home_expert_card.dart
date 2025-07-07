// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';

class DeveloperCard extends StatelessWidget {
  final double sh;
  final double sw;

  // New parameters for dynamic content
  final String name;
  final String subtitle;
  final double rate;
  final double rating;
  final int reviewCount;
  final String profileImageUrl;
  final String languages;
  final String experience;
  final List<String> expertise;

  const DeveloperCard({
    Key? key,
    required this.sh,
    required this.sw,
    required this.name,
    required this.subtitle,
    required this.rate,
    required this.rating,
    required this.reviewCount,
    required this.profileImageUrl,
    required this.languages,
    required this.experience,
    required this.expertise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(
          right: sw * 0.038,
          top: sh * 0.018,
          bottom: sh * 0.018,
          left: sh * 0.012,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //* Profile Image & Rating
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: sw * 0.029),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* TOP: Profile Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          profileImageUrl,
                          height: sh * 0.08,
                          width: sh * 0.08,
                          fit: BoxFit.cover,
                        ),
                      ),

                      //* BOTTOM: Rating Section
                      Padding(
                        padding: EdgeInsets.only(bottom: sh*0.01),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: sh * 0.017,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            FittedBox(
                              child: Text(
                                '$rating ($reviewCount)',
                                style: textStyle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sh * 0.016,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 0),

              //* Details & Chat Button
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // *TOP: Name / Subtitle / Languages / Experience / Skills
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: textStyle2.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: sh * 0.022,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: textStyle2.copyWith(
                            letterSpacing: 0.5,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: sh * 0.018,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          languages,
                          style: textStyle2.copyWith(
                            letterSpacing: 0.5,
                            color: Colors.grey.shade800,
                            fontSize: sh * 0.017,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          experience,
                          style: textStyle2.copyWith(
                            letterSpacing: 0.5,
                            color: Colors.grey.shade800,
                            fontSize: sh * 0.017,
                          ),
                        ),
                        SizedBox(height: 12),

                        //* Skill Pills
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: sw * 0.02,
                          runSpacing: sh * 0.01,
                          children: [
                            ...expertise
                                .take(4)
                                .map((skill) => _pill(skill, sh, sw)),
                            if (expertise.length > 4)
                              _pill("+${expertise.length - 4} more", sh, sw),
                          ],
                        ),

                        SizedBox(height: sh*0.022),

                        //* Rate text pinned above the buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                '\$$rate/min',
                                style: textStyle2.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: sh * 0.022,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/svg/chat_black.svg",
                                height: sh * 0.02,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Chat",
                                style: TextStyle(
                                  fontSize: sh * 0.018,
                                  fontFamily: "Jakarta-Medium",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.colorPurple,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.04,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _pill(String item, double h, double w) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: w * 0.03,
      vertical: h * 0.005,
    ),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      item,
      style: textStyle2.copyWith(
        fontSize: h * 0.015,
        color: Colors.grey.shade800,
      ),
    ),
  );
}
