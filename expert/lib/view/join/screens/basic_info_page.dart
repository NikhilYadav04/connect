import 'package:expert/controllers/controller_expert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Page 1: Basic Info Details
class BasicInfoPage extends StatefulWidget {
  final double sh;
  final double sw;

  const BasicInfoPage({super.key, required this.sh, required this.sw});

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  @override
  Widget build(BuildContext context) {
    double sh = widget.sh;
    double sw = widget.sw;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(sw * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
        child: Consumer<ExpertProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Title with circular badge
                Row(
                  children: [
                    Container(
                      width: sw * 0.08,
                      height: sw * 0.08,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C63FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                            fontSize: sh * 0.018,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: sh * 0.022,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Tell us about yourself",
                          style: TextStyle(
                            fontSize: sh * 0.014,
                            fontFamily: "Jakarta-Light",
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: sh * 0.04),

                // //* Profile Photo Section
                // Center(
                //   child: Stack(
                //     alignment: Alignment.bottomRight,
                //     children: [
                //       Container(
                //         width: sh * 0.16,
                //         height: sh * 0.16,
                //         decoration: BoxDecoration(
                //           color: const Color(0xFFE8E6FF),
                //           shape: BoxShape.circle,
                //           border: Border.all(
                //             color: Colors.white,
                //             width: 4,
                //           ),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.5),
                //               spreadRadius: 0,
                //               blurRadius: 8,
                //               offset: const Offset(0, 2),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Positioned(
                //         bottom: sh * 0.01,
                //         right: sh * 0.01,
                //         child: Container(
                //           padding: EdgeInsets.all(sw * 0.025),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFF6C63FF),
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //               color: Colors.white,
                //               width: 3,
                //             ),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: const Color(0xFF6C63FF).withOpacity(0.3),
                //                 spreadRadius: 0,
                //                 blurRadius: 8,
                //                 offset: const Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: Icon(
                //             Icons.camera_alt,
                //             color: Colors.white,
                //             size: sw * 0.045,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: sh * 0.015),
                // Center(
                //   child: Column(
                //     children: [
                //       Text(
                //         "Profile Photo",
                //         style: TextStyle(
                //           fontSize: sh * 0.018,
                //           fontFamily: "Jakarta-Medium",
                //           color: Colors.black,
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //       SizedBox(height: sh * 0.005),
                //       Text(
                //         "Upload a professional headshot",
                //         style: TextStyle(
                //           fontSize: sh * 0.016,
                //           fontFamily: "Jakarta-Light",
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: sh * 0.02),

                // Form Fields - All vertically aligned
                buildTextField(
                    "First Name", provider.firstNameController, sw, sh,
                    hintText: "Enter your first name", required: true),
                SizedBox(height: sh * 0.025),

                buildTextField("Last Name", provider.lastNameController, sw, sh,
                    hintText: "Enter your last name", required: true),
                SizedBox(height: sh * 0.025),

                buildTextField(
                    "Email Address", provider.emailController, sw, sh,
                    hintText: "your.email@example.com", required: true),
                SizedBox(height: sh * 0.025),

                buildTextField("Phone Number", provider.phoneController, sw, sh,
                    hintText: "+1 (555) 123-4567", required: true),
                SizedBox(height: sh * 0.04),

                //* Welcome Message
                Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(sw * 0.03),
                    border: Border.all(
                      color: const Color(0xFFE0E7FF),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.06),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(sw * 0.02),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: sw * 0.045,
                        ),
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to ProConnect!",
                              style: TextStyle(
                                fontSize: sh * 0.017,
                                fontFamily: "Jakarta-Medium",
                                color: Color.fromARGB(255, 14, 102, 190),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: sh * 0.008),
                            Text(
                              softWrap: true,
                              "We're excited to have you join our expert community. Your professional profile will help clients find and connect with you for personalized consultations.",
                              style: TextStyle(
                                fontSize: sh * 0.015,
                                fontFamily: "Jakarta-Medium",
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 12, 110, 209),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.02),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget buildTextField(
    String label, TextEditingController controller, double sw, double sh,
    {String? hintText, bool required = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontFamily: "Jakarta-Medium",
            fontSize: sh * 0.016,
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
          children: required
              ? [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: sh * 0.016,
                    ),
                  ),
                ]
              : [],
        ),
      ),
      SizedBox(height: sh * 0.008),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? 'Enter your ${label.toLowerCase()}',
          hintStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: sh * 0.017,
            fontFamily: "Jakarta-Light",
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sw * 0.02),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sw * 0.02),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sw * 0.02),
            borderSide: const BorderSide(
              color: Color(0xFF6C63FF),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: sw * 0.04,
            vertical: sh * 0.015,
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        style: TextStyle(
          fontSize: sh * 0.017,
          fontFamily: "Jakarta-Regular",
          color: Colors.black87,
        ),
      ),
    ],
  );
}
