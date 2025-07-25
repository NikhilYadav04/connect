import 'package:connect/core/utils/router/appRouter.dart';
import 'package:connect/core/utils/snackBar.dart';
import 'package:connect/http/models/api_reponse.dart';
import 'package:connect/http/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _auth = AuthService();

  late AnimationController _animationController;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleSignIn() async {
    if (_usernameController.text.trim().isEmpty) {
      showSnackBar('Please enter your email address', context, isError: true);
      return;
    }

    if (!_isValidEmail(_usernameController.text.trim())) {
      showSnackBar('Please enter a valid email address', context,
          isError: true);
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      showSnackBar('Please enter your password', context, isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      ApiResponse<Map<String, dynamic>> response = await _auth.login(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        showSnackBar('Login successful! Welcome back.', context,
            isError: false);
        Navigator.pushReplacementNamed(
          context,
          '/bottom-bar-screen',
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      } else {
        showSnackBar(response.message, context, isError: true);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(e.toString(), context, isError: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: 2,
              ),
              Container(
                padding: EdgeInsets.all(sw * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey[800],
                    size: sh * 0.025,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: sh * 0.000),

                //* Logo and App Title
                Column(
                  children: [
                    Container(
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
                    ),
                    SizedBox(height: sh * 0.025),
                    Text(
                      "PeerConnect",
                      style: TextStyle(
                        fontSize: sh * 0.036,
                        fontFamily: "Jakarta-Bold",
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: sh * 0.008),
                    Text(
                      "Connect with Expert Professionals",
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: "Jakarta-Light",
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.04),

                //* Welcome Section
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
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: sh * 0.028,
                          fontFamily: "Jakarta-Bold",
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: sh * 0.008),
                      Text(
                        "Sign in to your account to continue",
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: "Jakarta-Light",
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: sh * 0.04),

                      //* Username Field
                      _buildTextField(
                        "Username",
                        _usernameController,
                        sw,
                        sh,
                        hintText: "Enter your username or email",
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Password Field
                      _buildTextField(
                        "Password",
                        _passwordController,
                        sw,
                        sh,
                        hintText: "Enter your password",
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      SizedBox(height: sh * 0.01),

                      //* Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: sh * 0.017,
                              fontFamily: "Jakarta-Medium",
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sh * 0.015),

                      // *Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            //* Handle sign in
                            _handleSignIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                            ),
                          ),
                          child: _isLoading
                              ? _buildShimmerButton(sw, sh)
                              : Text(
                                  "Sign In",
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

                      //* Or Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: sw * 0.04),
                            child: Text(
                              "or",
                              style: TextStyle(
                                fontSize: sh * 0.014,
                                fontFamily: "Jakarta-Light",
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Sign In with Google Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle Google sign in
                            Navigator.pushNamed(
                              context,
                              '/bottom-bar-screen',
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
                              color: Colors.grey[400]!,
                              width: 1.5,
                            ),
                            padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                            ),
                          ),
                          icon: Container(
                            width: sw * 0.05,
                            height: sw * 0.05,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://developers.google.com/identity/images/g-logo.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          label: Text(
                            "Sign in with Google",
                            style: TextStyle(
                              fontSize: sh * 0.016,
                              fontFamily: "Jakarta-Medium",
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.04),

                //* Already have account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: "Jakarta-Light",
                        color: Colors.grey[600],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/sign-up-screen',
                          arguments: {
                            'transition': TransitionType.fade,
                            'duration': 300,
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: sh * 0.018,
                          fontFamily: "Jakarta-Medium",
                          color: const Color(0xFF6C63FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerButton(double sw, double sh) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: sh * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sw * 0.02),
            gradient: LinearGradient(
              begin: Alignment(-1.5, -1.5),
              end: Alignment(1.5, 1.5),
              colors: [
                const Color(0xFF6C63FF),
                const Color(0xFF6C63FF),
                Colors.white.withOpacity(0.7),
                const Color(0xFF6C63FF),
                const Color(0xFF6C63FF),
              ],
              stops: [
                0.0,
                (_animationController.value - 0.1).clamp(0.0, 1.0),
                _animationController.value.clamp(0.0, 1.0),
                (_animationController.value + 0.1).clamp(0.0, 1.0),
                1.0,
              ],
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: sw * 0.05,
                  height: sw * 0.05,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: sw * 0.03),
                Text(
                  "Signing In...",
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: "Jakarta-Medium",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double sw,
    double sh, {
    String? hintText,
    IconData? prefixIcon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Jakarta-Medium",
            fontSize: sh * 0.017,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: sh * 0.008),
        TextField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: sh * 0.017,
              fontFamily: "Jakarta-Light",
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Colors.grey[500],
                    size: sw * 0.052,
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey[500],
                      size: sw * 0.052,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: BorderSide(color: Colors.grey[500]!, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: BorderSide(color: Colors.grey[500]!, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sw * 0.02),
              borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: sw * 0.04,
              vertical: sh * 0.02,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          style: TextStyle(
            fontSize: sh * 0.018,
            fontFamily: "Jakarta-Regular",
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
