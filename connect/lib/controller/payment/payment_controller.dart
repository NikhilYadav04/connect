import 'package:connect/core/utils/snackBar.dart';
import 'package:connect/http/models/api_reponse.dart';
import 'package:connect/http/services/payment_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PaymentMethod { upi, creditDebitCard, netBanking, digitalWallets }

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  final TextEditingController amountController =
      TextEditingController(text: '100');

  //* Quick select amounts
  final List<int> quickAmounts = [100, 250, 500, 1000, 2000, 5000];

  //* Selected states
  int? _selectedQuickAmount;
  PaymentMethod? _selectedPaymentMethod;
  bool _isProcessingPayment = false;
  bool _isCreatingOrder = false;

  //* Minimum recharge amount
  static const int minimumAmount = 10;
  static double _GST = 18.0;

  //* Getters
  int? get selectedQuickAmount => _selectedQuickAmount;
  double get GST => _GST;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  bool get isProcessingPayment => _isProcessingPayment;
  bool get isCreatingOrder => _isCreatingOrder;
  bool get isValidAmount => getCurrentAmount() >= minimumAmount;

  //* Get current amount from controller or selected quick amount
  double getCurrentAmount() {
    if (_selectedQuickAmount != null) {
      return _selectedQuickAmount!.toDouble();
    }

    final customAmount = double.tryParse(amountController.text) ?? 0;
    return customAmount;
  }

  //* Select quick amount
  void selectQuickAmount(int amount) {
    _selectedQuickAmount = amount;
    amountController.clear();
    notifyListeners();
  }

  //* Clear quick amount selection when custom amount is entered
  void onCustomAmountChanged() {
    if (amountController.text.isNotEmpty) {
      _selectedQuickAmount = null;
      notifyListeners();
    }
  }

  //* Select payment method
  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  //* Create order
  Future<ApiResponse<Map<String, dynamic>>> createPaymentOrder() async {
    if (!isValidAmount) {
      throw Exception('Amount must be at least ₹$minimumAmount');
    }

    if (_selectedPaymentMethod == null) {
      throw Exception('Please select a payment method');
    }

    _isCreatingOrder = true;
    notifyListeners();

    try {
      final amount = getCurrentAmount();
      final response = await _paymentService.createOrder(amount: amount);

      return response;
    } catch (e) {
      rethrow;
    } finally {
      _isCreatingOrder = false;
      notifyListeners();
    }
  }

  //* Verify payment
  Future<ApiResponse<Map<String, dynamic>>> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String userId,
    required BuildContext context,
  }) async {
    _isProcessingPayment = true;
    notifyListeners();

    try {
      final amount = getCurrentAmount();
      final response = await _paymentService.verifyPayment(
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
        userId: userId,
        amount: amount,
      );

      if (response.success) {
        //* Update wallet
        final updatedAmount = response.data!['balance'];
        refreshWalletBalance(updatedAmount);

        //* Reset form on successful payment
        resetForm();
        showSnackBar('Payment verified and wallet updated', context,
            isError: false);
      } else {
        showSnackBar(response.message, context, isError: true);
      }

      return response;
    } catch (e) {
      showSnackBar(e.toString(), context, isError: true);
      rethrow;
    } finally {
      _isProcessingPayment = false;
      notifyListeners();
    }
  }

  //* Complete payment flow - creates order then initiates payment
  Future<void> initiatePayment({
    required String userId,
    required BuildContext context,
    required Function(Map<String, dynamic> orderData) onOrderCreated,
  }) async {
    try {
      //* Step 1: Create order
      final orderResponse = await createPaymentOrder();

      if (orderResponse.success && orderResponse.data != null) {
        //* Step 2: Pass order data to UI for Razorpay integration
        onOrderCreated(orderResponse.data!);
      } else {
        showSnackBar(orderResponse.message, context, isError: true);
      }
    } catch (e) {
      showSnackBar(e.toString(), context, isError: true);
    }
  }

  //* Refresh Wallet Amount For User
  Future<void> refreshWalletBalance(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('wallet_balance', amount);
  }

  //* Get payment method display name
  String getPaymentMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.upi:
        return 'UPI';
      case PaymentMethod.creditDebitCard:
        return 'Credit/Debit Card';
      case PaymentMethod.netBanking:
        return 'Net Banking';
      case PaymentMethod.digitalWallets:
        return 'Digital Wallets';
    }
  }

  //* Get payment method description
  String getPaymentMethodDescription(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.upi:
        return 'Pay using any UPI app';
      case PaymentMethod.creditDebitCard:
        return 'Visa, Mastercard, RuPay';
      case PaymentMethod.netBanking:
        return 'All major banks supported';
      case PaymentMethod.digitalWallets:
        return 'Paytm, PhonePe, Amazon Pay';
    }
  }

  //* Reset form
  void resetForm() {
    _selectedQuickAmount = 10;
    _selectedPaymentMethod = null;
    amountController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
