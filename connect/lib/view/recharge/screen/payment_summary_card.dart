import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double amount;
  final double sh; //* screen height
  final double sw; //* screen width

  const PaymentSummaryCard({
    super.key,
    required this.amount,
    required this.sh,
    required this.sw,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* Payment Summary Container with grey border
        Container(
          padding: EdgeInsets.all(sw * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(sw * 0.025),
            border: Border.all(
                color: Colors.grey.shade300), //* No shadow, only border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Title
              Text(
                "Payment Summary",
                style: TextStyle(
                  fontFamily: "Jakarta-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: sh * 0.022,
                ),
              ),
              SizedBox(height: sh * 0.015),

              //* Recharge Amount
              _rowItem("Recharge Amount", amount, isBold: false),

              SizedBox(
                height: sh * 0.012,
              ),

              _rowItem("GST", 18, isBold: false),

              Divider(height: sh * 0.03, thickness: 1),

              //* Total Amount
              _rowItem("Total Amount", amount + 18, isBold: true),
            ],
          ),
        ),

        SizedBox(height: sh * 0.025),

        //* Cancel and Process Buttons
        Row(
          children: [
            //* Cancel
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: sh * 0.018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: "Jakarta-Light",
                  ),
                ),
              ),
            ),
            SizedBox(width: sw * 0.03),

            //* Process
            Expanded(
              child: InkWell(
                onTap: () {
                  // handle tap
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: sh * 0.018),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF667CEB),
                        Color(0xFF8A74DA),
                        Color(0xFF8F3EB8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Process",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sh * 0.018,
                      fontFamily: "Jakarta-Medium",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: sh * 0.03),

        //* Secure Payment Info
        Container(
          padding: EdgeInsets.all(sw * 0.035),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(sw * 0.02),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Icon
              Icon(Icons.check_circle, color: Colors.blue, size: sh * 0.025),
              SizedBox(width: sw * 0.03),

              //* Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Secure Payment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sh * 0.018,
                        color: Colors.blue,
                        fontFamily: "Jakarta-Medium",
                      ),
                    ),
                    SizedBox(height: sh * 0.006),
                    Text(
                      "Your payment is secured by Razorpay with 256-bit SSL encryption. We never store your card details.",
                      style: TextStyle(
                        fontSize: sh * 0.015,
                        fontFamily: "Jakarta-Light",
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: sh * 0.025),
      ],
    );
  }

  //* Row Widget
  Widget _rowItem(String label, double value, {required bool isBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? sh * 0.02 : sh * 0.017,
            fontFamily: isBold ? "Jakarta-Medium" : "Jakarta-Light",
          ),
        ),
        Text(
          "₹${value.toStringAsFixed(0)}",
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? sh * 0.02 : sh * 0.017,
            fontFamily: isBold ? "Jakarta-Light" : "Jakarta-Light",
          ),
        ),
      ],
    );
  }
}
