import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: //* Back Arrow Button
                      Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
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
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
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
                                  //* Handle sign up
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
                          child: Text(
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
                        //* Navigate to sign in
                        Navigator.pop(context);
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
}
