import 'package:expert/model/session/model_sessions.dart';
import 'package:flutter/material.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  static const int _initialCount = 5;   //* show 5 at first
  static const int _expandedCount = 20; //* expand to 20
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
        );

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Sessions', style: bold(sw * 0.05, Colors.white)),
        backgroundColor: Colors.blueAccent,
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
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(iconFor(s.type), size: sw * 0.06),
                        SizedBox(width: sw * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(s.participant, style: bold(sw * 0.045)),
                                  SizedBox(width: sw * 0.02),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sw * 0.02,
                                      vertical: sh * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      labelFor(s.type),
                                      style: medium(sw * 0.035),
                                    ),
                                  ),
                                  SizedBox(width: sw * 0.02),
                                  Text(
                                    '${s.durationMinutes} min',
                                    style: medium(sw * 0.04),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${s.date.year}-${s.date.month.toString().padLeft(2, '0')}-${s.date.day.toString().padLeft(2, '0')}',
                              style: light(sw * 0.035, Colors.grey[600]),
                            ),
                            SizedBox(height: sh * 0.005),
                            Text(
                              '₹${s.amount.toStringAsFixed(2)}',
                              style: bold(sw * 0.045, Colors.green[700]),
                            ),
                          ],
                        ),
                        SizedBox(width: sw * 0.02),
                        Icon(Icons.arrow_forward_ios, size: sw * 0.04),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (recentSessions.length > _initialCount)
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
