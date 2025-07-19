import 'dart:io';
import 'package:expert/http/models/model_expert.dart';
import 'package:expert/http/services/auth_service.dart';
import 'package:flutter/material.dart';

class ExpertProvider with ChangeNotifier {
  final AuthService authService = AuthService();

  //* <------------- Expert Apply Management ------------->

  //* Basic Info Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //* Professional Details Controllers
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController linkedinUrlController = TextEditingController();

  //* Professional Details Variables
  String? selectedExperience;
  String? selectedCategory;
  String? selectedSubcategory;
  bool isAvailable = true;
  List<String> tags = [];

  //* Document Upload Variables
  File? companyIdCardFile;
  File? joiningLetterFile;
  File? degreeFile;
  File? otherCertificatesFile;

  //* Form Validation Variables
  String? errorMessage;

  //* Dropdown Options
  final List<String> experienceOptions = [
    '0-1 years',
    '1-3 years',
    '3-5 years',
    '5+ years',
  ];

  final List<String> categoryOptions = [
    'Technology',
    'Business',
    'Marketing',
    'Design',
    'Finance',
  ];

  final List<String> subcategoryOptions = [
    'Software Development',
    'Data Science',
    'Mobile Development',
    'Web Development',
  ];

  //* Professional Details Methods
  void updateExperience(String? experience) {
    selectedExperience = experience;
    notifyListeners();
  }

  void updateCategory(String? category) {
    selectedCategory = category;
    selectedSubcategory = null;
    notifyListeners();
  }

  void updateSubcategory(String? subcategory) {
    selectedSubcategory = subcategory;
    notifyListeners();
  }

  void updateAvailability(bool availability) {
    isAvailable = availability;
    notifyListeners();
  }

  //* Tag Management Methods
  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
      tagController.clear();
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
    notifyListeners();
  }

  //* Document Upload Methods
  void updateCompanyIdCard(File? file) {
    companyIdCardFile = file;
    notifyListeners();
  }

  void updateJoiningLetter(File? file) {
    joiningLetterFile = file;
    notifyListeners();
  }

  void updateDegree(File? file) {
    degreeFile = file;
    notifyListeners();
  }

  void updateOtherCertificates(File? file) {
    otherCertificatesFile = file;
    notifyListeners();
  }

  //* Validation Methods
  bool validateBasicInfo() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  bool validateProfessionalDetails() {
    return jobTitleController.text.isNotEmpty &&
        companyController.text.isNotEmpty &&
        selectedExperience != null &&
        selectedCategory != null &&
        selectedSubcategory != null &&
        bioController.text.isNotEmpty &&
        linkedinUrlController.text.isNotEmpty &&
        rateController.text.isNotEmpty;
  }

  bool validateDocuments() {
    return companyIdCardFile != null &&
        joiningLetterFile != null &&
        degreeFile != null;
  }

  bool validateAllForms() {
    return validateBasicInfo() &&
        validateProfessionalDetails() &&
        validateDocuments();
  }

  //* Form Data Compilation
  Map<String, dynamic> getFormData() {
    return {
      'fullName': '${firstNameController.text} ${lastNameController.text}',
      'email': emailController.text,
      'phone': phoneController.text,
      'category': selectedCategory,
      'subcategory': selectedSubcategory,
      'experienceYears': _parseExperienceToYears(selectedExperience),
      'bio': bioController.text,
      'currentCompany': companyController.text,
      'currentDesignation': jobTitleController.text,
      'linkedinUrl': linkedinUrlController.text,
      'ratePerMinute': double.tryParse(rateController.text) ?? 0.0,
      'isAvailable': isAvailable,
      'tags': tags,
    };
  }

  //* Helper Methods
  int _parseExperienceToYears(String? experience) {
    if (experience == null) return 0;
    switch (experience) {
      case '0-1 years':
        return 1;
      case '1-3 years':
        return 2;
      case '3-5 years':
        return 4;
      case '5+ years':
        return 6;
      default:
        return 0;
    }
  }

  String get fullName =>
      '${firstNameController.text} ${lastNameController.text}';

  bool get hasRequiredDocuments =>
      companyIdCardFile != null &&
      joiningLetterFile != null &&
      degreeFile != null;

  bool get companyIdCardUploaded => companyIdCardFile != null;
  bool get joiningLetterUploaded => joiningLetterFile != null;
  bool get degreeUploaded => degreeFile != null;
  bool get otherCertificatesUploaded => otherCertificatesFile != null;

  int get uploadedDocumentsCount {
    int count = 0;
    if (companyIdCardUploaded) count++;
    if (joiningLetterUploaded) count++;
    if (degreeUploaded) count++;
    return count;
  }

  int get completedSteps {
    int steps = 0;
    if (validateBasicInfo()) steps++;
    if (validateProfessionalDetails()) steps++;
    if (validateDocuments()) steps++;
    return steps;
  }

  double get formProgress => completedSteps / 3.0;

  //* API Submission Method
  Future<void> submitExpertApplication() async {
    if (!validateAllForms()) {
      setError('Please complete all required fields');
      return;
    }

    try {
      clearError();

      final formData = getFormData();

      String? degreeCertificatePath = degreeFile?.path;
      String? idProofPath = companyIdCardFile?.path;
      String? offerLetterPath = joiningLetterFile?.path;
      String? otherCertificatePath = otherCertificatesFile?.path;

      if (degreeCertificatePath == null || idProofPath == null) {
        setError('Required documents are missing');
        return;
      }

      final response = await authService.applyAsExpert(
        fullName: formData['fullName'],
        email: formData['email'],
        phone: formData['phone'],
        category: formData['category'],
        subcategory: formData['subcategory'],
        experienceYears: formData['experienceYears'],
        bio: formData['bio'],
        currentCompany: formData['currentCompany'],
        currentDesignation: formData['currentDesignation'],
        linkedinUrl: formData['linkedinUrl'],
        degreeCertificatePath: degreeCertificatePath,
        idProofPath: idProofPath,
        offerLetterPath: offerLetterPath,
        otherCertificatePath: otherCertificatePath,
      );

      if (response.success) {
        clearError();
      } else {
        setError('Failed to submit application: ${response.message}');
      }
    } catch (e) {
      setError('Failed to submit application: ${e.toString()}');
    }
  }

  //* Reset Methods
  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    jobTitleController.clear();
    companyController.clear();
    bioController.clear();
    rateController.clear();
    tagController.clear();
    linkedinUrlController.clear();

    selectedExperience = null;
    selectedCategory = null;
    selectedSubcategory = null;
    isAvailable = true;
    tags.clear();

    companyIdCardFile = null;
    joiningLetterFile = null;
    degreeFile = null;
    otherCertificatesFile = null;

    errorMessage = null;
    notifyListeners();
  }

  //* Error Handling
  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  //* Dispose Controllers
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    jobTitleController.dispose();
    companyController.dispose();
    bioController.dispose();
    rateController.dispose();
    tagController.dispose();
    linkedinUrlController.dispose();
    super.dispose();
  }

//* <------------- Expert Data Management ------------->
  ExpertModel? _expertData;

  ExpertModel? get expertData => _expertData;

  double _payoutAmount = 0.0;

  double get payoutAmount => _payoutAmount;

  void setExpertData(ExpertModel? data) {
    _expertData = data;
    notifyListeners();
  }

  void applyAsExpert(ExpertModel expertModel) {
    _expertData = expertModel;
    notifyListeners();
  }

  Future<void> getExpertDetails(String userId) async {
    if (_expertData != null) return;

    try {
      final response = await authService.getUserStatsById(userId: userId);
      if (response.success && response.data != null) {
        _expertData = response.data;
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to fetch expert details: ${e.toString()}');
    }
  }

  Future<void> refreshExpertDetails(String userId) async {
    try {
      final response = await authService.getUserStatsById(userId: userId);
      if (response.success && response.data != null) {
        _expertData = response.data;
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to refresh expert details: ${e.toString()}');
    }
  }

  Future<void> getExpertPayout(String userId) async {
    try {
      final response = await authService.getExpertPayout(userId: userId);
      if (response.success && response.data != null) {
        _payoutAmount = response.data?['pendingAmount'];
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to fetch payout details: ${e.toString()}');
    }
  }

  void clearAll() {
    _expertData = null;
    _payoutAmount = 0.0;
    notifyListeners();
  }
}
