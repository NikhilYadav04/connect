import 'dart:io';

import 'package:connect/core/utils/router/appRouter.dart';
import 'package:connect/core/utils/snackBar.dart';
import 'package:connect/http/models/api_reponse.dart';
import 'package:connect/http/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  File? _selectedProfilePhoto;

  late AnimationController _animationController;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _acceptTermsGoogle = false;

  bool _isLoading = false;
  final _auth = AuthService();

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleSignUp() async {
    if (_firstNameController.text.trim().isEmpty) {
      showSnackBar('Please enter your first name', context, isError: true);
      return;
    }

    if (_lastNameController.text.trim().isEmpty) {
      showSnackBar('Please enter your last name', context, isError: true);
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      showSnackBar('Please enter your email address', context, isError: true);
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      showSnackBar('Please enter a valid email address', context,
          isError: true);
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      showSnackBar('Please enter your phone number', context, isError: true);
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      showSnackBar('Please enter your password', context, isError: true);
      return;
    }

    if (_confirmPasswordController.text.trim().isEmpty) {
      showSnackBar('Please confirm your password', context, isError: true);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      showSnackBar('Passwords do not match', context, isError: true);
      return;
    }

    if (!_acceptTerms) {
      showSnackBar('Please accept the terms and conditions', context,
          isError: true);
      return;
    }

    if(_selectedProfilePhoto == null){
      showSnackBar('Upload your profile photo!', context,
          isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';

      ApiResponse<Map<String, dynamic>> response = await _auth.register(
          fullName: fullName,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
          profilePicture: _selectedProfilePhoto);

      if (response.statusCode == 201) {
        showSnackBar('Registration successful! Welcome.', context,
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
      showSnackBar(e.toString(), context, isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //* Add this method to your _SignUpScreenState class:
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedProfilePhoto = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
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

                //* Sign Up Section
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
                        "Create Account",
                        style: TextStyle(
                          fontSize: sh * 0.028,
                          fontFamily: "Jakarta-Bold",
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: sh * 0.008),
                      Text(
                        "Join our community of expert professionals",
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: "Jakarta-Light",
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: sh * 0.03),

                      Center(
                        child: Column(
                          children: [
                            // Profile Photo Circle (Display Only)
                            Container(
                              width: sw * 0.3,
                              height: sw * 0.3,
                              decoration: BoxDecoration(
                                color: _selectedProfilePhoto != null
                                    ? Colors.transparent
                                    : const Color(0xFFF0F4FF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedProfilePhoto != null
                                      ? const Color(0xFF6C63FF)
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: _selectedProfilePhoto != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _selectedProfilePhoto!,
                                        fit: BoxFit.cover,
                                        width: sw * 0.3,
                                        height: sw * 0.3,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person_outline,
                                      size: sw * 0.12,
                                      color: Colors.grey[400],
                                    ),
                            ),
                            SizedBox(height: sh * 0.02),
                            Text(
                              "Profile Photo",
                              style: TextStyle(
                                fontSize: sh * 0.018,
                                fontFamily: "Jakarta-Medium",
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: sh * 0.005),
                            Text(
                              "Choose how to add your photo",
                              style: TextStyle(
                                fontSize: sh * 0.015,
                                fontFamily: "Jakarta-Light",
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(height: sh * 0.02),

                            // Camera and Gallery Cards
                            Row(
                              children: [
                                // Camera Card
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _pickImage(ImageSource.camera),
                                    child: Container(
                                      padding: EdgeInsets.all(sw * 0.04),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius:
                                            BorderRadius.circular(sw * 0.03),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(sw * 0.04),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6C63FF)
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: const Color(0xFF6C63FF),
                                              size: sw * 0.08,
                                            ),
                                          ),
                                          SizedBox(height: sh * 0.015),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                              fontSize: sh * 0.016,
                                              fontFamily: "Jakarta-Medium",
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: sh * 0.005),
                                          Text(
                                            "Take photo",
                                            style: TextStyle(
                                              fontSize: sh * 0.013,
                                              fontFamily: "Jakarta-Light",
                                              color: Colors.grey[600],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: sw * 0.04),

                                // Gallery Card
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        _pickImage(ImageSource.gallery),
                                    child: Container(
                                      padding: EdgeInsets.all(sw * 0.04),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius:
                                            BorderRadius.circular(sw * 0.03),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(sw * 0.04),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6C63FF)
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.photo_library_outlined,
                                              color: const Color(0xFF6C63FF),
                                              size: sw * 0.08,
                                            ),
                                          ),
                                          SizedBox(height: sh * 0.015),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                              fontSize: sh * 0.016,
                                              fontFamily: "Jakarta-Medium",
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: sh * 0.005),
                                          Text(
                                            "Choose photo",
                                            style: TextStyle(
                                              fontSize: sh * 0.013,
                                              fontFamily: "Jakarta-Light",
                                              color: Colors.grey[600],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.025),

                      _buildTextField(
                        "First Name",
                        _firstNameController,
                        sw,
                        sh,
                        hintText: "Enter first name",
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Name Fields Row
                      _buildTextField(
                        "Last Name",
                        _lastNameController,
                        sw,
                        sh,
                        hintText: "Enter last name",
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Email Field
                      _buildTextField(
                        "Email Address",
                        _emailController,
                        sw,
                        sh,
                        hintText: "Enter your email address",
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Phone Number Field
                      _buildTextField(
                        "Phone Number",
                        _phoneController,
                        sw,
                        sh,
                        hintText: "+91 9152502571",
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Password Field
                      _buildTextField(
                        "Password",
                        _passwordController,
                        sw,
                        sh,
                        hintText: "Create a strong password",
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        isConfirmPassword: false,
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Confirm Password Field
                      _buildTextField(
                        "Confirm Password",
                        _confirmPasswordController,
                        sw,
                        sh,
                        hintText: "Confirm your password",
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        isConfirmPassword: true,
                      ),
                      SizedBox(height: sh * 0.02),

                      //* Terms and Conditions Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: _acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptTerms = value ?? false;
                                });
                              },
                              activeColor: const Color(0xFF6C63FF),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          SizedBox(width: sw * 0.01),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: sh * 0.01),
                              child: RichText(
                                text: TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontSize: sh * 0.0155,
                                    fontFamily: "Jakarta-Light",
                                    color: Colors.grey[600],
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextStyle(
                                        fontSize: sh * 0.0155,
                                        fontFamily: "Jakarta-Medium",
                                        color: const Color(0xFF6C63FF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        fontSize: sh * 0.0155,
                                        fontFamily: "Jakarta-Light",
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        fontSize: sh * 0.0155,
                                        fontFamily: "Jakarta-Medium",
                                        color: const Color(0xFF6C63FF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.025),

                      //* Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton(
                          onPressed: _acceptTerms
                              ? () {
                                  _handleSignUp();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _acceptTerms
                                ? const Color(0xFF6C63FF)
                                : Colors.grey[400],
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.02),
                            ),
                          ),
                          child: _isLoading
                              ? _buildShimmerButton(sw, sh)
                              : Text(
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

                      //* Sign Up with Google Button
                      SizedBox(
                        width: double.infinity,
                        height: sh * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            //* Handle Google sign up
                            _showGoogleSignUpPopup();
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
                            "Sign up with Google",
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
                SizedBox(height: sh * 0.03),

                //* Already have account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
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
                          '/sign-in-screen',
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
                        "Sign In",
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
                SizedBox(height: sh * 0.03),
              ],
            ),
          ),
        ),
      ),
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
    bool isConfirmPassword = false,
    TextInputType? keyboardType,
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
          obscureText: isPassword
              ? (isConfirmPassword ? _obscureConfirmPassword : _obscurePassword)
              : false,
          keyboardType: keyboardType,
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
                        if (isConfirmPassword) {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        } else {
                          _obscurePassword = !_obscurePassword;
                        }
                      });
                    },
                    icon: Icon(
                      (isConfirmPassword
                              ? _obscureConfirmPassword
                              : _obscurePassword)
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

  void _showGoogleSignUpPopup() {
    final TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        double sh = MediaQuery.of(context).size.height;
        double sw = MediaQuery.of(context).size.width;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: sw * 0.05,
            vertical: sh * 0.1,
          ),
          child: SingleChildScrollView(
            child: Container(
              width: sw * 0.9,
              constraints: BoxConstraints(
                maxHeight: sh * 0.8, // Prevent overflow
              ),
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Header with close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Complete Sign Up",
                          style: TextStyle(
                            fontSize: sh * 0.024,
                            fontFamily: "Jakarta-Bold",
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: EdgeInsets.all(sw * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey[600],
                            size: sw * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.008),
                  Text(
                    "Just one more step to complete your Google sign up",
                    style: TextStyle(
                      fontSize: sh * 0.016,
                      fontFamily: "Jakarta-Light",
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: sh * 0.025),

                  //* Google Account Info
                  Container(
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(sw * 0.02),
                      border: Border.all(
                        color: const Color(0xFFE0E7FF),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
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
                        SizedBox(width: sw * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Google Account",
                                style: TextStyle(
                                  fontSize: sh * 0.015,
                                  fontFamily: "Jakarta-Medium",
                                  color: const Color(0xFF6C63FF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Connected successfully",
                                style: TextStyle(
                                  fontSize: sh * 0.013,
                                  fontFamily: "Jakarta-Light",
                                  color: const Color(0xFF6C63FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: sw * 0.045,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sh * 0.02),

                  //* Phone Number Field
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      fontFamily: "Jakarta-Medium",
                      fontSize: sh * 0.017,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: sh * 0.008),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "+91 9152502571",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: sh * 0.017,
                        fontFamily: "Jakarta-Light",
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: Colors.grey[500],
                        size: sw * 0.052,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(sw * 0.02),
                        borderSide:
                            BorderSide(color: Colors.grey[500]!, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(sw * 0.02),
                        borderSide:
                            BorderSide(color: Colors.grey[500]!, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(sw * 0.02),
                        borderSide: const BorderSide(
                            color: Color(0xFF6C63FF), width: 2),
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
                  SizedBox(height: sh * 0.02),

                  //* Terms acceptance for Google signup
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) {
                            //* This will update the main screen's state
                            setState(() {
                              _acceptTermsGoogle = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF6C63FF),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      SizedBox(width: sw * 0.01),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: sh * 0.01),
                          child: RichText(
                            text: TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontSize: sh * 0.013,
                                fontFamily: "Jakarta-Light",
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    fontSize: sh * 0.013,
                                    fontFamily: "Jakarta-Medium",
                                    color: const Color(0xFF6C63FF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    fontSize: sh * 0.013,
                                    fontFamily: "Jakarta-Light",
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: sh * 0.013,
                                    fontFamily: "Jakarta-Medium",
                                    color: const Color(0xFF6C63FF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.02),

                  //* Complete Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: sh * 0.06,
                    child: ElevatedButton(
                      onPressed:
                          _acceptTermsGoogle && phoneController.text.isNotEmpty
                              ? () {
                                  //* Handle Google sign up completion
                                  Navigator.of(context).pop();
                                  // Add your Google sign up logic here
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _acceptTermsGoogle &&
                                phoneController.text.isNotEmpty
                            ? const Color(0xFF6C63FF)
                            : Colors.grey[400],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.02),
                        ),
                      ),
                      child: Text(
                        "Complete Sign Up",
                        style: TextStyle(
                          fontSize: sh * 0.018,
                          fontFamily: "Jakarta-Medium",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.01),

                  //* Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: sh * 0.05,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: sh * 0.01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sw * 0.02),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: "Jakarta-Medium",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                  "Creating Account...",
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
}
