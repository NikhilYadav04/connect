import 'package:connect/http/models/api_reponse.dart';
import 'package:connect/http/utils/api_endpoints.dart';

import 'api_service.dart';

class PaymentService extends ApiService {
  //* Create Razorpay Order
  Future<ApiResponse<Map<String, dynamic>>> createOrder({
    required double amount,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createOrder,
      data: {
        'amount': amount,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Verify Payment
  Future<ApiResponse<Map<String, dynamic>>> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String userId,
    required double amount,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.verifyPayment,
      data: {
        'razorpay_order_id': razorpayOrderId,
        'razorpay_payment_id': razorpayPaymentId,
        'razorpay_signature': razorpaySignature,
        'userId': userId,
        'amount': amount,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }
}
