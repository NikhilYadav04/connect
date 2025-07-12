import 'package:connect/core/utils/router/appRouter.dart';
import 'package:connect/http/utils/http_client.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HttpClient _httpClient = HttpClient();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    //* Display splash for 2 seconds minimum
    await Future.delayed(Duration(seconds: 2));

    //* Check authentication status
    final bool isLoggedIn = await _httpClient.isAuthenticated();

    //* Navigate based on authentication
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          '/bottom-bar-screen',
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          '/landing_screen',
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double sh = MediaQuery.of(context).size.height;
    final double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(sw),
              SizedBox(height: sh * 0.025),
              _buildAppTitle(sh),
              SizedBox(height: sh * 0.008),
              _buildSubtitle(sh),
              SizedBox(height: sh * 0.06),
              _buildLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(double sw) {
    return Container(
      width: sw * 0.25,
      height: sw * 0.25,
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
        Icons.connect_without_contact,
        color: Colors.white,
        size: sw * 0.12,
      ),
    );
  }

  Widget _buildAppTitle(double sh) {
    return Text(
      "PeerConnect",
      style: TextStyle(
        fontSize: sh * 0.036,
        fontFamily: "Jakarta-Bold",
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSubtitle(double sh) {
    return Text(
      "Connect with Expert Professionals",
      style: TextStyle(
        fontSize: sh * 0.018,
        fontFamily: "Jakarta-Light",
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        const Color(0xFF6C63FF),
      ),
      strokeWidth: 3,
    );
  }
}
