import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatefulWidget {
  final double sh;
  final double sw;

  const PaymentMethodSelector({
    super.key,
    required this.sh,
    required this.sw,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String selectedMethod = 'UPI';

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'title': 'UPI',
      'subtitle': 'Pay using any UPI app',
      'icon': Icons.phone_android,
      'color': Colors.green,
      'isPopular': true,
    },
    {
      'title': 'Credit/Debit Card',
      'subtitle': 'Visa, Mastercard, RuPay',
      'icon': Icons.credit_card,
      'color': Colors.indigo,
    },
    {
      'title': 'Net\nBanking',
      'subtitle': 'All major banks supported',
      'icon': Icons.account_balance,
      'color': Colors.purple,
    },
    {
      'title': 'Digital\nWallets',
      'subtitle': 'Paytm, PhonePe, Amazon Pay',
      'icon': Icons.account_balance_wallet,
      'color': Colors.deepOrange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sh = widget.sh;
    final sw = widget.sw;

    return Container(
    //  color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sh * 0.02),
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontFamily: 'Jakarta-Medium',
              fontSize: sh * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: sh * 0.02),
          //* Wrap GridView in SizedBox to prevent overflow
          SizedBox(
            height: sh * 0.33, //* adjust this depending on your screen height
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: sh * 0.0016,
              crossAxisSpacing: sw * 0.012,
              mainAxisSpacing: sh * 0.02,
              physics: const BouncingScrollPhysics(),
              children: paymentMethods.map((method) {
                final bool isSelected = method['title'] == selectedMethod;
      
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = method['title'];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: sh * 0.015, horizontal: sw * 0.01),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Icon
                            CircleAvatar(
                              radius: sh * 0.018,
                              backgroundColor: method['color'],
                              child: Icon(
                                method['icon'],
                                color: Colors.white,
                                size: sh * 0.02,
                              ),
                            ),
                            SizedBox(width: sw * 0.01),
      
                            //* Right content: title, popular tag, subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //* Title
                                  Text(
                                    maxLines: 2,
                                    softWrap: true,
                                    method['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Jakarta-Medium',
                                      fontSize: sh * 0.018,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
      
                                  // Popular tag (if any)
                                  if (method['isPopular'] == true)
                                    Container(
                                      margin: EdgeInsets.only(top: sh * 0.004),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: sw * 0.015,
                                        vertical: sh * 0.003,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'Popular',
                                        style: TextStyle(
                                          fontSize: sh * 0.013,
                                          fontFamily: 'Jakarta-Medium',
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
      
                            //* Check icon if selected
                            if (isSelected)
                              Icon(Icons.check_circle,
                                  color: Colors.blue, size: sh * 0.025),
                          ],
                        ),
                        SizedBox(
                          height: sh * 0.01,
                        ),
                        //* Subtitle
                        Text(
                          method['subtitle'],
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'Jakarta-Light',
                            fontSize: sh * 0.016,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
