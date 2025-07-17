import 'package:expert/controllers/controller_expert.dart';
import 'package:expert/core/constants/snackBar.dart';
import 'package:expert/core/router/appRouter.dart';
import 'package:expert/view/join/screens/basic_info_page.dart';
import 'package:expert/view/join/screens/document_upload_page.dart';
import 'package:expert/view/join/screens/professional_info_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpertSignUpScreen extends StatefulWidget {
  const ExpertSignUpScreen({super.key});

  @override
  State<ExpertSignUpScreen> createState() => _ExpertSignUpScreenState();
}

class _ExpertSignUpScreenState extends State<ExpertSignUpScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _handleNext1(ExpertProvider provider, BuildContext context) {
    //* Check if all fields are filled
    if (provider.firstNameController.text.isEmpty) {
      showSnackBar('First name is required', context, isError: true);
      return false;
    }

    if (provider.lastNameController.text.isEmpty) {
      showSnackBar('Last name is required', context, isError: true);
      return false;
    }

    if (provider.emailController.text.isEmpty) {
      showSnackBar('Email is required', context, isError: true);
      return false;
    }

    if (provider.phoneController.text.isEmpty) {
      showSnackBar('Phone number is required', context, isError: true);
      return false;
    }

    //* Email validation with regex
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(provider.emailController.text.trim())) {
      showSnackBar('Please enter a valid email address', context,
          isError: true);
      return false;
    }

    //* Phone validation (at least 10 digits)
    String phoneDigits =
        provider.phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (phoneDigits.length < 10) {
      showSnackBar('Phone number must be at least 10 digits', context,
          isError: true);
      return false;
    }

    //* If all validations pass
    return true;
  }

  bool _handleNext2(ExpertProvider provider, BuildContext context) {
    //* Check if all required fields are filled
    if (provider.jobTitleController.text.isEmpty) {
      showSnackBar('Job title is required', context, isError: true);
      return false;
    }

    if (provider.companyController.text.isEmpty) {
      showSnackBar('Company name is required', context, isError: true);
      return false;
    }

    if (provider.selectedExperience == null) {
      showSnackBar('Years of experience is required', context, isError: true);
      return false;
    }

    if (provider.selectedCategory == null) {
      showSnackBar('Primary category is required', context, isError: true);
      return false;
    }

    if (provider.selectedSubcategory == null) {
      showSnackBar('Subcategory is required', context, isError: true);
      return false;
    }

    if (provider.bioController.text.isEmpty) {
      showSnackBar('Professional bio is required', context, isError: true);
      return false;
    }

    if (provider.linkedinUrlController.text.isEmpty) {
      showSnackBar('LinkedIn profile is required', context, isError: true);
      return false;
    }

    if (provider.rateController.text.isEmpty) {
      showSnackBar('Rate per minute is required', context, isError: true);
      return false;
    }

    //* Validate LinkedIn URL format
    final linkedinRegex =
        RegExp(r'^https?://(www\.)?linkedin\.com/in/[a-zA-Z0-9-]+/?$');
    if (!linkedinRegex.hasMatch(provider.linkedinUrlController.text.trim())) {
      showSnackBar('Please enter a valid LinkedIn profile URL', context,
          isError: true);
      return false;
    }

    //* Validate rate is a valid number
    final rate = double.tryParse(provider.rateController.text);
    if (rate == null || rate <= 0) {
      showSnackBar('Please enter a valid rate amount', context, isError: true);
      return false;
    }

    if (rate < 1 || rate > 1000) {
      showSnackBar('Rate should be between ₹1 and ₹1000 per minute', context,
          isError: true);
      return false;
    }

    //* Bio length validation
    if (provider.bioController.text.length < 50) {
      showSnackBar('Bio should be at least 50 characters long', context,
          isError: true);
      return false;
    }

    //* If all validations pass
    return true;
  }

  bool _handleNext3(ExpertProvider provider, BuildContext context) {
    //* Check if all required documents are uploaded using provider booleans
    if (!provider.companyIdCardUploaded) {
      showSnackBar('Company ID Card is required', context, isError: true);
      return false;
    }

    if (!provider.joiningLetterUploaded) {
      showSnackBar('Joining Letter is required', context, isError: true);
      return false;
    }

    if (!provider.degreeUploaded) {
      showSnackBar('Degree Certificate is required', context, isError: true);
      return false;
    }

    //* If all validations pass
    showSnackBar('All documents uploaded successfully!', context,
        isError: false);
    return true;
  }

  void _applyAsExpertAPICall() {
    // final provider = Provider.of<ExpertProvider>(context, listen: false);

    // if (_handleNext1(provider, context) &&
    //     _handleNext2(provider, context) &&
    //     _handleNext3(provider, context)) {
    //   provider.submitExpertApplication();
    // } else {
    //   return;
    // }
    Navigator.pushNamed(
      context,
      '/expert-approval-loader',
      arguments: {
        'transition': TransitionType.rightToLeft,
        'duration': 300,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE7EEFF),
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
                      onPressed: () {
                        if (_currentPage > 0) {
                          setState(() => _currentPage--);
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: sw * 0.06,
                      ),
                      label: Text(
                        _currentPage > 0 ? 'Back' : 'Exit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: sh * 0.02,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: BorderSide(
                          color: Colors.grey.shade900,
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
                        print(_currentPage);
                        if (_currentPage < 2) {
                          setState(() => _currentPage++);
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          _applyAsExpertAPICall();
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
