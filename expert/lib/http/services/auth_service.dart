import 'package:dio/dio.dart';
import 'package:expert/http/models/api_reponse.dart';
import 'package:expert/http/models/model_expert.dart';
import 'package:expert/http/services/api_service.dart';
import '../utils/api_endpoints.dart';
import '../utils/http_client.dart';

//* AuthService handles authentication API calls
class AuthService extends ApiService {
  final HttpClient _httpClient = HttpClient();

  //* Login with email and password
  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.loginAsExpert,
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Save token and user ID if login successful
    if (response.success && response.data != null) {
      final token = response.data!['token'];
      final userData = response.data!['user'];

      if (token != null && userData != null) {
        final userId = userData['id'] ?? userData['_id'];
        if (token != null && userId != null) {
          //* Save both token and user ID
          await _httpClient.saveAuthToken(
            token,
          );

          await _httpClient.saveUserData(userId);
        } else {
          //* Fallback: save only token if no user ID
          await _httpClient.saveAuthToken(token);
        }
      }
    }

    return response;
  }

  //* Apply as Expert with multiple file fields
  Future<ApiResponse<Map<String, dynamic>>> applyAsExpert({
    required String fullName,
    required String email,
    required String phone,
    required String category,
    required String subcategory,
    required int experienceYears,
    required String bio,
    required String currentCompany,
    required String currentDesignation,
    required String linkedinUrl,
    required String degreeCertificatePath,
    required String idProofPath,
    String? offerLetterPath,
    String? otherCertificatePath,
  }) async {
    final Map<String, dynamic> formDataMap = {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'category': category,
      'subcategory': subcategory,
      'experienceYears': experienceYears.toString(),
      'bio': bio,
      'currentCompany': currentCompany,
      'currentDesignation': currentDesignation,
      'linkedinUrl': linkedinUrl,
      'degreeCertificate': await MultipartFile.fromFile(
        degreeCertificatePath,
        filename: degreeCertificatePath.split('/').last,
      ),
      'idProof': await MultipartFile.fromFile(
        idProofPath,
        filename: idProofPath.split('/').last,
      ),
    };

    // Add optional files if provided
    if (offerLetterPath != null) {
      formDataMap['offerLetter'] = await MultipartFile.fromFile(
        offerLetterPath,
        filename: offerLetterPath.split('/').last,
      );
    }

    if (otherCertificatePath != null) {
      formDataMap['otherCertificate'] = await MultipartFile.fromFile(
        otherCertificatePath,
        filename: otherCertificatePath.split('/').last,
      );
    }

    final formData = FormData.fromMap(formDataMap);

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.applyAsExpert,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

//* Upload Profile Picture
  Future<ApiResponse<Map<String, dynamic>>> uploadProfilePicture({
    required String id,
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      ),
    });

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.updateExpertProfile(id),
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Get User Stats by ID
  Future<ApiResponse<ExpertModel>> getUserStatsById({
    required String userId,
  }) async {
    final response = await get<ExpertModel>(ApiEndpoints.getExpertStats(userId),
        fromJson: (data) => ExpertModel.fromJson(data), isDirectJson: true);

    return response;
  }

  Future<ApiResponse<Map<String, dynamic>>> getExpertPayout({
    required String userId,
  }) async {
    final response = await get<Map<String, dynamic>>(
        ApiEndpoints.getPayout(userId),
        fromJson: (data) => data as Map<String, dynamic>,
        isDirectJson: true);

    return response;
  }

  //* Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _httpClient.isAuthenticated();
  }
}
