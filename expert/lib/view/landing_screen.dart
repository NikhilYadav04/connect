import 'package:expert/core/router/appRouter.dart';
import 'package:flutter/material.dart';

class ExpertLandingScreen extends StatelessWidget {
  const ExpertLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: sh * 0.02),

                //* Back Arrow Button

                SizedBox(height: sh * 0.04),

                //* Logo and App Title
                Column(
                  children: [
                    Container(
                      width: sw * 0.3,
                      height: sw * 0.3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: sw * 0.15,
                      ),
                    ),
                    SizedBox(height: sh * 0.025),
                    Text(
                      "PeerConnect",
                      style: TextStyle(
                        fontSize: sh * 0.038,
                        fontFamily: "Jakarta-Bold",
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: sh * 0.008),
                    Text(
                      "Expert Platform",
                      style: TextStyle(
                        fontSize: sh * 0.022,
                        fontFamily: "Jakarta-Medium",
                        color: const Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: sh * 0.008),
                    Text(
                      "Share your expertise and earn income",
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: "Jakarta-Light",
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.08),

                //* Expert Options Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sw * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Welcome Title
                      FittedBox(
                        child: Text(
                          "Join Our Expert Community",
                          style: TextStyle(
                            fontSize: sh * 0.026,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.008),
                      FittedBox(
                        child: Text(
                          "Connect with clients seeking your expertise",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: sh * 0.016,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.03),

                      //* Expert Benefits
                      // Container(
                      //   padding: EdgeInsets.all(sw * 0.04),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFFF0F4FF),
                      //     borderRadius: BorderRadius.circular(sw * 0.03),
                      //     border: Border.all(
                      //       color: const Color(0xFFE0E7FF),
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       _buildBenefitItem(
                      //           sw,
                      //           sh,
                      //           Icons.monetization_on_outlined,
                      //           "Earn Income",
                      //           "Set your rates and earn from consultations"),
                      //       SizedBox(height: sh * 0.02),
                      //       _buildBenefitItem(
                      //           sw,
                      //           sh,
                      //           Icons.schedule_outlined,
                      //           "Flexible Schedule",
                      //           "Work on your own time and availability"),
                      //       SizedBox(height: sh * 0.02),
                      //       _buildBenefitItem(
                      //           sw,
                      //           sh,
                      //           Icons.people_outline,
                      //           "Global Reach",
                      //           "Connect with clients worldwide"),
                      //     ],
                      //   ),
                      // ),

                      //* Join as Expert Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //* Navigate to expert registration
                            // TODO: logout logic
                            Navigator.pushNamed(
                              context,
                              '/expert-join-screen',
                              arguments: {
                                'transition': TransitionType.fade,
                                'duration': 300,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                            ),
                          ),
                          icon: Icon(
                            Icons.person_add_outlined,
                            color: Colors.white,
                            size: sw * 0.05,
                          ),
                          label: Text(
                            "Join as Expert",
                            style: TextStyle(
                              fontSize: sh * 0.018,
                              fontFamily: "Jakarta-Medium",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Login as Expert Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //* Navigate to expert login
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            side: BorderSide(
                              color: const Color(0xFF6C63FF),
                              width: 1.5,
                            ),
                            padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                            ),
                          ),
                          icon: Icon(
                            Icons.login_outlined,
                            color: const Color(0xFF6C63FF),
                            size: sw * 0.05,
                          ),
                          label: Text(
                            "Login as Expert",
                            style: TextStyle(
                              fontSize: sh * 0.018,
                              fontFamily: "Jakarta-Medium",
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.03),

                //* Additional Info
                Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9F1),
                    borderRadius: BorderRadius.circular(sw * 0.02),
                    border: Border.all(
                      color: const Color(0xFFE8F5E9),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                        size: sw * 0.06,
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Text(
                          "All experts go through a verification process to ensure quality and credibility",
                          style: TextStyle(
                            fontSize: sh * 0.015,
                            fontFamily: "Jakarta-Light",
                            color: Colors.green[700],
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
      double sw, double sh, IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(sw * 0.02),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6C63FF),
            size: sw * 0.04,
          ),
        ),
        SizedBox(width: sw * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: sh * 0.015,
                  fontFamily: "Jakarta-Medium",
                  color: const Color(0xFF6C63FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: sh * 0.013,
                  fontFamily: "Jakarta-Light",
                  color: const Color(0xFF6C63FF),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
