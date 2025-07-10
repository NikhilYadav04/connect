import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:expert/view/home/screen/home_drawer_screen.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(sh: sh, sw: sw),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: sh * 0.074,
          backgroundColor: AppColors.colorPurple,
          centerTitle: true,
          title: Text(
            "Analytics",
            style: textStyle2.copyWith(
              wordSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: sh * 0.027,
            ),
          ),
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: sh * 0.04,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.colorLightGrayBG,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.04,
            vertical: sh * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //* Title and subtitle
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.01, vertical: sh * 0.00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expert Dashboard",
                      style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 0.8,
                        fontFamily: 'Jakarta-Medium',
                        fontSize: sh * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: sh * 0.015),
                    Text(
                      "Manage your expertise and track your performance.",
                      style: TextStyle(
                        fontFamily: 'Jakarta-Light',
                        fontSize: sh * 0.018,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: sh * 0.022,
              ),

              StatsCard(
                sw: sw,
                sh: sh,
                icon: Icons.repeat,
                iconColor: Colors.green,
                title: 'Repeat Clients',
                value: '89%',
                progress: 0.89,
              ),
              SizedBox(height: sh * 0.02),
              StatsCard(
                sw: sw,
                sh: sh,
                icon: Icons.star,
                iconColor: Colors.amber,
                title: 'Avg. Rating',
                value: '4.8',
                progress: 4.8 / 5.0,
              ),
              SizedBox(height: sh * 0.02),
              StatsCard(
                sw: sw,
                sh: sh,
                icon: Icons.access_time,
                iconColor: Colors.blue,
                title: 'Response Time',
                value: '2.5m',
                progress: 0.75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final double sw;
  final double sh;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final double progress;

  const StatsCard({
    Key? key,
    required this.sw,
    required this.sh,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //* Left side: title and value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Jakarta-Light',
                        fontSize: sw * 0.04,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: sh * 0.005),
                    Text(
                      value,
                      style: textStyle3.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: sw * 0.07,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),

              //* Right side: Icon
              Container(
                padding: EdgeInsets.all(sw * 0.03),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  size: sw * 0.07,
                  color: iconColor,
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: sh * 0.01,
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(iconColor),
            ),
          ),
        ],
      ),
    );
  }
}
