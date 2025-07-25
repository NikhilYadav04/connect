import 'package:connect/controller/user/user_controller.dart';
import 'package:connect/core/utils/router/appRouter.dart';
import 'package:connect/view/home/widgets/logout_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final double sh, sw;
  const AppDrawer({Key? key, required this.sh, required this.sw})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
      backgroundColor: Colors.white,
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
                      userProvider.userModel?.displayName[0] ??
                          'D', // or load network image
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
                        userProvider.userModel?.displayName ?? "Dummy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jakarta-Medium',
                          fontSize: sh * 0.025,
                        ),
                      ),
                      SizedBox(height: sh * 0.005),
                      Text(
                        '+91-${userProvider.userModel?.phone}',
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
                          'transition': TransitionType.topToBottom,
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
                      showLogoutDialog(context, sh: sh, sw: sw);
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

Future<bool?> showLogoutDialog(BuildContext context,
    {required double sh, required double sw}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LogoutConfirmationDialog(sh: sh, sw: sw);
    },
  );
}
