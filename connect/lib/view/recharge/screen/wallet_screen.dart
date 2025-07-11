import 'package:connect/view/recharge/screen/payment_method_card.dart';
import 'package:connect/view/recharge/screen/payment_summary_card.dart';
import 'package:flutter/material.dart';

class RechargeWalletScreen extends StatefulWidget {
  const RechargeWalletScreen({super.key});

  @override
  State<RechargeWalletScreen> createState() => _RechargeWalletScreenState();
}

class _RechargeWalletScreenState extends State<RechargeWalletScreen> {
  final List<int> quickAmounts = [100, 250, 500, 1000, 2000, 5000];
  int selectedAmount = 100;
  TextEditingController customAmountController =
      TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: sh * 0.04,
        backgroundColor: Colors.white,
        leading: Padding(
            padding: EdgeInsets.only(left: sw * 0.032),
            child: GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: sh * 0.035,
              ),
            )),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.025),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.blue[700],
                      size: sh * 0.036,
                    ),
                    SizedBox(
                      width: sw * 0.02,
                    ),
                    Text(
                      'Recharge Wallet',
                      style: TextStyle(
                        fontFamily: 'Jakarta-Medium',
                        fontSize: sh * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.015),
                Text(
                  'Add money to your wallet to start consultations with experts.',
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Jakarta-Light',
                    fontSize: sh * 0.018,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: sh * 0.025),
                Container(
                  padding: EdgeInsets.all(sh * 0.02),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[700]!),
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Balance',
                              style: TextStyle(
                                fontFamily: 'Jakarta-Light',
                                fontSize: sh * 0.018,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: sh * 0.005),
                            Text(
                              '₹1,250',
                              style: TextStyle(
                                fontFamily: 'Jakarta-Medium',
                                fontSize: sh * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: sh * 0.035,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.04),
                Text(
                  'Quick Select Amount',
                  style: TextStyle(
                    fontFamily: 'Jakarta-Medium',
                    fontSize: sh * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: sh * 0.02),
                Wrap(
                  spacing: sw * 0.03,
                  runSpacing: sh * 0.015,
                  children: quickAmounts.map((amount) {
                    final isSelected = selectedAmount == amount;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAmount = amount;
                          customAmountController.text = amount.toString();
                        });
                      },
                      child: Container(
                        width: sw * 0.26,
                        padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '₹$amount',
                            style: TextStyle(
                              fontFamily: 'Jakarta-Medium',
                              fontSize: sh * 0.02,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: sh * 0.04),
                Text(
                  'Or Enter Custom Amount',
                  style: TextStyle(
                    fontFamily: 'Jakarta-Medium',
                    fontSize: sh * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: sh * 0.015),
                TextField(
                  controller: customAmountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final intVal = int.tryParse(value);
                    if (intVal != null) {
                      setState(() {
                        selectedAmount = intVal;
                      });
                    }
                  },
                  style: TextStyle(
                    fontFamily: 'Jakarta-Light',
                    fontSize: sh * 0.02,
                  ),
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    labelText: '₹ 100',
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                      fontFamily: 'Jakarta-Light',
                      fontSize: sh * 0.02,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: sw * 0.04,
                      vertical: sh * 0.02,
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.01),
                Text(
                  'Minimum recharge amount: ₹10',
                  style: TextStyle(
                    fontFamily: 'Jakarta-Light',
                    fontSize: sh * 0.017,
                    color: Colors.grey,
                  ),
                ),
                //  SizedBox(height: sh * 0.01),
                PaymentMethodSelector(
                  sh: sh,
                  sw: sh,
                ),
                PaymentSummaryCard(amount: 125.00, sh: sh, sw: sw)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
