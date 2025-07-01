import 'package:connect/core/constants/colors.dart';
import 'package:connect/core/constants/fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget headerTitle(double sh, double sw) {
  return Row(
    children: [
      Container(
        height: sh * 0.044,
        width: sw * 0.098,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/group.svg",
            width: sh * 0.026,
            height: sh * 0.026,
          ),
        ),
      ),
      SizedBox(
        width: sw * 0.03,
      ),
      Text(
        "PeerConnect",
        style: textStyle2.copyWith(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: sh * 0.0245,
            fontWeight: FontWeight.bold),
      ),
      Spacer(),
      Container(
        height: sh * 0.044,
        width: sw * 0.098,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey.withOpacity(0.45)),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: sh * 0.026,
            height: sh * 0.026,
          ),
        ),
      ),
    ],
  );
}

Widget walletButton(double sh, double sw) {
  return Container(
    height: sh * 0.125,
    padding: EdgeInsets.symmetric(
      horizontal: sw * 0.03,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [Color(0xFF4ADE80), Color(0xFF3B82F6)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //* Wallet Info
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wallet Balance',
                style: textStyle2.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 231, 228, 228),
                  fontSize: sh * 0.02,
                ),
              ),
              SizedBox(height: sh * 0.003),
              Text(
                '\$124.50',
                style: textStyle2.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: sh * 0.035,
                ),
              ),
            ],
          ),
        ),

        //* Recharge Button
        TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: sh * 0.03,
          ),
          label: Text(
            'Recharge',
            style:
                textStyle2.copyWith(color: Colors.white, fontSize: sh * 0.02),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.1),
            padding: EdgeInsets.symmetric(
                horizontal: sw * 0.04, vertical: sh * 0.015),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    ),
  );
}

Widget titleText(String title, double sh) {
  return Text(
    title,
    style: textStyle2.copyWith(
      letterSpacing: 2,
      wordSpacing: 2,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: sh * 0.033,
    ),
  );
}

Widget subtitleText(String title, double sh) {
  return Text(
    title,
    style: textStyle2.copyWith(
      letterSpacing: 0.6,
      wordSpacing: 2,
      color: Colors.grey.shade300,
      fontWeight: FontWeight.bold,
      fontSize: sh * 0.02,
    ),
  );
}

Widget expertsLabel(double sh) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      label1(sh, "Trending Experts", Colors.grey.shade900, sh * 0.025),
      label1(sh, "View All", AppColors.colorPurple, sh * 0.022),
    ],
  );
}

Widget label1(double sh, String title, Color color, double fontsSize) {
  return Text(
    title,
    style: textStyle2.copyWith(
        letterSpacing: 1,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontsSize),
  );
}
