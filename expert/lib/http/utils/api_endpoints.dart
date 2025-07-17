//* API endpoints matching your Node.js backend routes exactly
class ApiEndpoints {
  //* Authentication endpoints
  static const String applyAsExpert = '/experts/apply';
  static const String loginAsExpert = '/experts/login';
  String uploadProfilePicture(String id) =>
      '/experts/uploadProfilePicture/:${id}';

  //* Expert EndPoints
  static String getExpertStats(String id) => '/expert/getExpert/${id}';
  static String updateExpertProfile(String id) => '/expert/updateExpert/${id}';
}
