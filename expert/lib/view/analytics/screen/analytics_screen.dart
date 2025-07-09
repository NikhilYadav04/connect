import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Analytics',
            style: TextStyle(
              fontFamily: 'Jakarta-Medium',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.05,
            vertical: sh * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
              SizedBox(width: sw * 0.04),
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
                      style: TextStyle(
                        fontFamily: 'Jakarta-Bold',
                        fontSize: sw * 0.06,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: sh * 0.008,
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
