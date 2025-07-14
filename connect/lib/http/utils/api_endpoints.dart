//* API endpoints matching your Node.js backend routes exactly
class ApiEndpoints {
  //* Authentication endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  //* Payment Endpoints
  static const String createOrder = '/create-order';
  static const String verifyPayment = '/verify-payment';

  // //* Dynamic endpoints
  static String getUserById(String id) => '/getUser/$id';
  static String postById(String id) => '/posts/$id';
  static String userPosts(String userId) => '/users/$userId/posts';

  //* Experts
  static const String getAllExperts = '/allExperts';
  static String getExpertsByCategory(String categoryId) =>
      '/byCategory/${categoryId}';
}
