import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    // Jakarta font helpers
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

    // Reusable card widget: either a solid color or gradient background
    Widget infoCard({
      Color? color,
      Gradient? gradient,
      required Widget child,
      double heightFactor = 0.12,
    }) {
      return Container(
        width: sw * 0.9,
        height: sh * heightFactor,
        margin: EdgeInsets.symmetric(vertical: sh * 0.01),
        padding: EdgeInsets.all(sw * 0.04),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: sh * 0.02),
          child: Center(
            child: Column(
              children: [
                // — Header with gradient background —
                infoCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A6CF7), Color(0xFF8D4CF7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  heightFactor: 0.2,
                  child: Row(
                    children: [
                      // Avatar + camera icon
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: sw * 0.12,
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: sw * 0.04,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt,
                                size: sw * 0.05,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: sw * 0.04),
                      // Name, Verified badge, specialty, rating, status, rate
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Dr. Sarah Johnson',
                                  style: bold(sw * 0.055, Colors.white),
                                ),
                                SizedBox(width: sw * 0.02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sw * 0.02,
                                    vertical: sh * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Verified',
                                    style: light(sw * 0.035, Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: sh * 0.008),
                            Text(
                              'Tech & Product  •  ⭐ 4.8 (234)',
                              style: medium(sw * 0.04, Colors.white70),
                            ),
                            SizedBox(height: sh * 0.008),
                            Row(
                              children: [
                                Text(
                                  'Online Status:',
                                  style: medium(sw * 0.035, Colors.white70),
                                ),
                                Switch(value: true, onChanged: (_) {}),
                                Spacer(),
                                Text(
                                  '₹150.00/hour',
                                  style: medium(sw * 0.04, Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // — Stats cards: each with a solid color —
                infoCard(
                  color: Colors.green[400]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lifetime Earnings', style: light(sw * 0.04, Colors.white70)),
                      Spacer(),
                      Text('₹2,85,000.00', style: bold(sw * 0.065, Colors.white)),
                    ],
                  ),
                ),
                infoCard(
                  color: Colors.blue[400]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monthly Earnings', style: light(sw * 0.04, Colors.white70)),
                      Spacer(),
                      Text('₹45,000.00', style: bold(sw * 0.065, Colors.white)),
                    ],
                  ),
                ),
                infoCard(
                  color: Colors.purple[400]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Sessions', style: light(sw * 0.04, Colors.white70)),
                      Spacer(),
                      Text('1,247', style: bold(sw * 0.065, Colors.white)),
                    ],
                  ),
                ),
                infoCard(
                  color: Colors.orange[400]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Minutes', style: light(sw * 0.04, Colors.white70)),
                      Spacer(),
                      Text('18,420', style: bold(sw * 0.065, Colors.white)),
                    ],
                  ),
                ),

                // — Pending Payout block —
                infoCard(
                  color: Colors.yellow[100]!,
                  child: Row(
                    children: [
                      // Text column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pending Payout', style: medium(sw * 0.045)),
                            SizedBox(height: sh * 0.005),
                            Text('₹8,500.00', style: bold(sw * 0.07)),
                            SizedBox(height: sh * 0.005),
                            Text('Available for withdrawal', style: light(sw * 0.035)),
                          ],
                        ),
                      ),
                      // Withdraw button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[700],
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05,
                            vertical: sh * 0.015,
                          ),
                        ),
                        icon: const Icon(Icons.download_rounded),
                        label: Text('Withdraw', style: medium(sw * 0.04)),
                        onPressed: () {},
                      ),
                      SizedBox(width: sw * 0.02),
                      // View Details button
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[600]!),
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.04,
                            vertical: sh * 0.015,
                          ),
                        ),
                        child: Text('View Details', style: medium(sw * 0.04)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
