import 'package:connect/core/router/appRouter.dart';
import 'package:flutter/material.dart';

class ClientLandingScreen extends StatelessWidget {
  const ClientLandingScreen({super.key});

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
                        Icons.search_outlined,
                        color: Colors.white,
                        size: sw * 0.15,
                      ),
                    ),
                    SizedBox(height: sh * 0.025),
                    Text(
                      "ProConnect",
                      style: TextStyle(
                        fontSize: sh * 0.038,
                        fontFamily: "Jakarta-Bold",
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: sh * 0.008),
                    Text(
                      "Find Expert Consultation",
                      style: TextStyle(
                        fontSize: sh * 0.022,
                        fontFamily: "Jakarta-Medium",
                        color: const Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: sh * 0.008),
                    Text(
                      "Connect with verified professionals instantly",
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: "Jakarta-Light",
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.06),

                //* Client Options Section
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
                          "Get Expert Guidance",
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
                          "Access professional consultation services",
                          style: TextStyle(
                            fontSize: sh * 0.016,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.03),

                      //* Client Benefits
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
                      //           Icons.verified_user_outlined,
                      //           "Verified Experts",
                      //           "All professionals are thoroughly vetted"),
                      //       SizedBox(height: sh * 0.02),
                      //       _buildBenefitItem(
                      //           sw,
                      //           sh,
                      //           Icons.video_call_outlined,
                      //           "Instant Consultation",
                      //           "Connect via video, audio, or chat"),
                      //       SizedBox(height: sh * 0.02),
                      //       _buildBenefitItem(
                      //           sw,
                      //           sh,
                      //           Icons.star_outline,
                      //           "Quality Guaranteed",
                      //           "Rated and reviewed by real clients"),
                      //     ],
                      //   ),
                      // ),

                      //* Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //* Navigate to client sign up
                             Navigator.pushNamed(
                              context,
                              '/sign-up-screen',
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
                            "Create Account",
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

                      //* Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //* Navigate to client sign in
                             Navigator.pushNamed(
                              context,
                              '/sign-in-screen',
                              arguments: {
                                'transition': TransitionType.fade,
                                'duration': 300,
                              },
                            );
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
                            "Sign In",
                            style: TextStyle(
                              fontSize: sh * 0.018,
                              fontFamily: "Jakarta-Medium",
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.03),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.03),

                //* Popular Categories
                // Container(
                //   padding: EdgeInsets.all(sw * 0.06),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(sw * 0.02),
                //     border: Border.all(
                //       color: Colors.grey[200]!,
                //       width: 1,
                //     ),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Popular Categories",
                //         style: TextStyle(
                //           fontSize: sh * 0.018,
                //           fontFamily: "Jakarta-Medium",
                //           color: Colors.black87,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       SizedBox(height: sh * 0.015),
                //       Wrap(
                //         spacing: sw * 0.02,
                //         runSpacing: sh * 0.01,
                //         children: [
                //           _buildCategoryChip(
                //               sw, sh, "Technology", Icons.computer),
                //           _buildCategoryChip(
                //               sw, sh, "Business", Icons.business),
                //           _buildCategoryChip(
                //               sw, sh, "Marketing", Icons.campaign),
                //           _buildCategoryChip(
                //               sw, sh, "Design", Icons.design_services),
                //           _buildCategoryChip(
                //               sw, sh, "Finance", Icons.account_balance),
                //           _buildCategoryChip(sw, sh, "Legal", Icons.gavel),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: sh * 0.03),

                //* Trust Indicators
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
                        Icons.security_outlined,
                        color: Colors.green,
                        size: sw * 0.06,
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Text(
                          "Your data is secure and all payments are protected by industry-standard encryption",
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

  Widget _buildCategoryChip(
      double sw, double sh, String category, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.03,
        vertical: sh * 0.008,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(sw * 0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF6C63FF),
            size: sw * 0.035,
          ),
          SizedBox(width: sw * 0.01),
          Text(
            category,
            style: TextStyle(
              fontSize: sh * 0.012,
              fontFamily: "Jakarta-Medium",
              color: const Color(0xFF6C63FF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
