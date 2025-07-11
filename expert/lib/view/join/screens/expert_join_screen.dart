import 'package:expert/view/join/screens/basic_info_page.dart';
import 'package:expert/view/join/screens/document_upload_page.dart';
import 'package:expert/view/join/screens/professional_info_page.dart';
import 'package:flutter/material.dart';

class ExpertSignUpScreen extends StatefulWidget {
  const ExpertSignUpScreen({super.key});

  @override
  State<ExpertSignUpScreen> createState() => _ExpertSignUpScreenState();
}

class _ExpertSignUpScreenState extends State<ExpertSignUpScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  Color(0xFFE7EEFF),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.03),
              Text(
                "Join as an Expert",
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: sh * 0.031,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Jakarta-Medium",
                ),
              ),
              SizedBox(height: sh * 0.012),
              Text(
                "Share your expertise and help others succeed. Start earning by providing professional consultations.",
                style: TextStyle(
                  fontSize: sh * 0.018,
                  fontFamily: "Jakarta-Light",
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: sh * 0.015),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BasicInfoPage(sh: sh, sw: sw),
                    ProfessionalDetailsPage(sh: sh, sw: sw),
                    DocumentVerificationPage(sh: sh, sw: sw),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.02,
                  vertical: sh * 0.015,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _currentPage > 0
                          ? () {
                              setState(() => _currentPage--);
                              _pageController.animateToPage(
                                _currentPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_back,
                        color: _currentPage > 0 ? Colors.black : Colors.grey,
                        size: sw * 0.06,
                      ),
                      label: Text(
                        'Back',
                        style: TextStyle(
                          color: _currentPage > 0 ? Colors.black : Colors.grey,
                          fontSize: sh * 0.02,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: BorderSide(
                          color: _currentPage > 0
                              ? Colors.grey.shade900
                              : Colors.grey.shade300,
                          width: sw * 0.002,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.04,
                          vertical: sh * 0.012,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.02),
                        ),
                      ),
                    ),

                    //* Next/Submit button
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_currentPage < 2) {
                          setState(() => _currentPage++);
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          print("Form submitted!");
                        }
                      },
                      icon: Icon(
                        _currentPage == 2
                            ? Icons.check_circle_outline
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: sw * 0.06,
                      ),
                      label: Text(
                        _currentPage == 2 ? 'Submit for Review' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sh * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 2
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF8B5CF6),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.04,
                          vertical: sh * 0.012,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
