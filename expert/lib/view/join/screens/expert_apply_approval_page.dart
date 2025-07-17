import 'package:flutter/material.dart';
import 'dart:math' as math;

class ApplicationSubmittedPage extends StatefulWidget {
  const ApplicationSubmittedPage({super.key});

  @override
  State<ApplicationSubmittedPage> createState() =>
      _ApplicationSubmittedPageState();
}

class _ApplicationSubmittedPageState extends State<ApplicationSubmittedPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _rotateController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _rotateController.forward();

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(sw * 0.04),
          child: Column(
            children: [
              SizedBox(height: sh * 0.05),

              // Success Icon with Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: AnimatedBuilder(
                    animation: _rotateAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: Container(
                          width: sw * 0.3,
                          height: sw * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF8B7EFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6C63FF).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: sh * 0.05),

              // Title with Slide Animation
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    "Application Submitted!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: sh * 0.035,
                      fontFamily: "Jakarta-Bold",
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.02),

              // Subtitle
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  "Thank you for applying to become an expert!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: "Jakarta-Medium",
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),

              // Status Card with Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sw * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Status Icon with Pulse Animation
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: EdgeInsets.all(sw * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.schedule,
                                color: Colors.orange[700],
                                size: sw * 0.08,
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: sh * 0.03),

                      Text(
                        "Under Review",
                        style: TextStyle(
                          fontSize: sh * 0.024,
                          fontFamily: "Jakarta-Bold",
                          color: Colors.orange[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: sh * 0.015),

                      Text(
                        "Our team is carefully reviewing your application and documents. This process ensures we maintain the highest quality of experts on our platform.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: "Jakarta-Light",
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),

              // Simple Review Info
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sw * 0.05),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(sw * 0.03),
                    border: Border.all(
                      color: const Color(0xFFE0E7FF),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: const Color(0xFF6C63FF),
                            size: sw * 0.06,
                          ),
                          SizedBox(width: sw * 0.03),
                          Text(
                            "Document Verification",
                            style: TextStyle(
                              fontSize: sh * 0.020,
                              fontFamily: "Jakarta-Bold",
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.02),
                      Text(
                        "We will verify your documents within 24-48 hours. If approved, welcome to our expert community!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: "Jakarta-Medium",
                          color: Colors.grey[700],
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),

              // Email Notification Info
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(sw * 0.03),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.green[700],
                        size: sw * 0.06,
                      ),
                      SizedBox(width: sw * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stay Updated",
                              style: TextStyle(
                                fontSize: sh * 0.016,
                                fontFamily: "Jakarta-Medium",
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: sh * 0.005),
                            Text(
                              "We'll send you email updates at each step of the review process.",
                              style: TextStyle(
                                fontSize: sh * 0.014,
                                fontFamily: "Jakarta-Light",
                                color: Colors.green[600],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: sh * 0.05),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/landing-screen',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: sh * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sw * 0.03),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: sh * 0.018,
                      fontFamily: "Jakarta-Medium",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
