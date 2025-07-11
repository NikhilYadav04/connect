import 'package:expert/core/constants/colors.dart';
import 'package:expert/core/constants/fontFamily.dart';
import 'package:expert/model/session/model_sessions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  static const int _initialCount = 5;
  static const int _expandedCount = 20;
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

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
        fontWeight: FontWeight.bold);

    final count = _showMore
        ? (_expandedCount <= recentSessions.length
            ? _expandedCount
            : recentSessions.length)
        : (_initialCount <= recentSessions.length
            ? _initialCount
            : recentSessions.length);

    IconData iconFor(SessionType t) {
      switch (t) {
        case SessionType.video:
          return Icons.videocam;
        case SessionType.chat:
          return Icons.chat_bubble;
        case SessionType.phone:
          return Icons.phone;
      }
    }

    String labelFor(SessionType t) {
      switch (t) {
        case SessionType.video:
          return 'Video';
        case SessionType.chat:
          return 'Chat';
        case SessionType.phone:
          return 'Phone';
      }
    }

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
                        "Recent Sessions",
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
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.04,
            vertical: sh * 0.02,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, i) {
                    final s = recentSessions[i];
                    return Container(
                      margin: EdgeInsets.only(bottom: sh * 0.015),
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
                      child: Skeletonizer(
                        enabled: false,
                        effect: ShimmerEffect(
                            duration: Duration(milliseconds: 1500)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* Left: Icon + Name
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(iconFor(s.type), size: sh * 0.03),
                                    SizedBox(width: sw * 0.03),
                                    Text(
                                      s.participant,
                                      style: bold(
                                        sh * 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                //* Right: Type + Duration
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: sw * 0.025,
                                        vertical: sh * 0.005,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        labelFor(s.type),
                                        style: medium(sh * 0.017),
                                      ),
                                    ),
                                    SizedBox(width: sw * 0.025),
                                    Text(
                                      '${s.durationMinutes} min',
                                      style: medium(sh * 0.017),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: sh * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${s.date.year}-${s.date.month.toString().padLeft(2, '0')}-${s.date.day.toString().padLeft(2, '0')}',
                                  style: light(sh * 0.017, Colors.grey[700]),
                                ),
                                Text(
                                  '₹${s.amount.toStringAsFixed(2)}',
                                  style: textStyle1.copyWith(
                                      fontSize: sh * 0.023,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (recentSessions.length > _initialCount)
                TextButton(
                  onPressed: () => setState(() => _showMore = !_showMore),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _showMore ? 'View Less' : 'View More',
                        style: bold(sh * 0.021, AppColors.colorPurple),
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
            ],
          ),
        ),
      ),
    );
  }
}
