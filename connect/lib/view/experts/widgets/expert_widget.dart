// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:connect/core/utils/router/appRouter.dart';

class WalletAmountBadge extends StatelessWidget {
  final double sh;
  final double sw;
  final String walletAmount;

  const WalletAmountBadge({
    Key? key,
    required this.sh,
    required this.sw,
    required this.walletAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/wallet-screen',
          arguments: {
            'transition': TransitionType.topToBottom,
            'duration': 300,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sw * 0.03,
          vertical: sh * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), // Soft background for violet
          borderRadius: BorderRadius.circular(sw * 0.02),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              size: sw * 0.048,
              color: Colors.white,
            ),
            SizedBox(width: sw * 0.015),
            Text(
              '₹${walletAmount}',
              style: TextStyle(
                fontFamily: "Jakarta-Light",
                fontSize: sw * 0.039,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
