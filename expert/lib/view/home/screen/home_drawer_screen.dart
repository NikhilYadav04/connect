import 'package:expert/core/router/appRouter.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final double sh, sw;
  const AppDrawer({Key? key, required this.sh, required this.sw})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildItem({
      required IconData icon,
      required String title,
      Color? color,
      VoidCallback? onTap,
    }) {
      return ListTile(
        leading: Icon(icon, size: sh * 0.03, color: color ?? Colors.black87),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Jakarta-Light',
            fontSize: sh * 0.022,
            color: color ?? Colors.black87,
          ),
        ),
        onTap: onTap ?? () => Navigator.pop(context),
      );
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: sh * 0.03,
            ),
            //* --- Profile header with icon and name/number ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.04,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: sh * 0.038,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      'H', // or load network image
                      style: TextStyle(
                        fontFamily: 'Jakarta-Medium',
                        fontSize: sh * 0.032,
                      ),
                    ),
                  ),
                  SizedBox(width: sw * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hitesh',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jakarta-Medium',
                          fontSize: sh * 0.025,
                        ),
                      ),
                      SizedBox(height: sh * 0.005),
                      Text(
                        '+91-9355207485',
                        style: TextStyle(
                          fontFamily: 'Jakarta-Light',
                          fontSize: sh * 0.018,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sh * 0.02,
            ),

            Divider(),

            //* --- Three menu items ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildItem(
                    icon: Icons.history,
                    title: 'Session History',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/session-history');
                    },
                  ),
                  _buildItem(
                    icon: Icons.account_balance_wallet,
                    title: 'Wallet History',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/wallet-screen',
                        arguments: {
                          'transition': TransitionType.fade,
                          'duration': 300,
                        },
                      );
                    },
                  ),
                  Divider(),
                  _buildItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: logout logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
