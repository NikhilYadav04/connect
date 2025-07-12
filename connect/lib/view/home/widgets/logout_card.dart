import 'package:connect/core/utils/snackBar.dart';
import 'package:connect/http/services/auth_service.dart';
import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final double sh; // Screen height
  final double sw; // Screen width

  const LogoutConfirmationDialog({
    Key? key,
    required this.sh,
    required this.sw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: sw * 0.85, // 85% of screen width
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Warning Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFFF6B6B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                color: Color(0xFFFF6B6B),
                size: 28,
              ),
            ),

            SizedBox(height: 20),

            //* Title
            Text(
              'Logout Confirmation',
              style: TextStyle(
                fontFamily: 'Jakarta-Medium',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            //* Message
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                fontFamily: 'Jakarta-Light',
                fontSize: 16,
                color: Color(0xFF718096),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32),

            //* Buttons
            Row(
              children: [
                //* No Button
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFF7FAFC),
                      foregroundColor: Color(0xFF4A5568),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontFamily: 'Jakarta-Medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12),

                //* Yes Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final _auth = AuthService();
                      final response = await _auth.logout(context);

                      if (response.statusCode != 200) {
                        showSnackBar('Error Signing Out!', context,
                            isError: true);
                      }

                      Navigator.of(context).pop(false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6366F1), // Purple theme
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontFamily: 'Jakarta-Medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
