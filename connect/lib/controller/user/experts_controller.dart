import 'package:connect/core/utils/snackBar.dart';
import 'package:connect/http/models/model_expert.dart';
import 'package:connect/http/services/user_service.dart';
import 'package:flutter/material.dart';

class ExpertsProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  //* Category title to ID mapping
  static const Map<String, String> _categoryTitleToId = {
    'Mentoring': 'mentoring',
    'Finance & Investment': 'finance_investment',
    'Legal & Compliance': 'legal_compliance',
    'Diet & Nutrition': 'diet_nutrition',
    'Medical & HealthCare': 'medical_healthcare',
    'Astrology': 'astrology',
    'Life & Relationship': 'life_relationship',
    'Tech & Product': 'tech_product',
    'Real Estate & Property': 'real_estate_property',
  };

  final Map<String, List<ExpertModel>> _expertsByCategory = {};
  final Map<String, bool> _loadingStates = {};

  //* Getters
  Map<String, List<ExpertModel>> get expertsByCategory =>
      Map.unmodifiable(_expertsByCategory);
  Map<String, bool> get loadingStates => Map.unmodifiable(_loadingStates);

  List<ExpertModel>? getExpertsByTitle(String categoryTitle) {
    return _expertsByCategory[categoryTitle];
  }

  bool isCategoryLoading(String categoryTitle) {
    return _loadingStates[categoryTitle] ?? false;
  }

  bool hasCategoryData(String categoryTitle) {
    return _expertsByCategory.containsKey(categoryTitle) &&
        _expertsByCategory[categoryTitle]!.isNotEmpty;
  }

  //* Load experts by category - prevents duplicate API calls
  Future<void> loadExpertsByCategory(
      String categoryTitle, BuildContext context) async {
    if (hasCategoryData(categoryTitle)) return;

    final categoryId = _categoryTitleToId[categoryTitle];
    if (categoryId == null) {
      throw Exception('Unknown category title: $categoryTitle');
    }

    _loadingStates[categoryTitle] = true;
    notifyListeners();

    try {
      final response = await _userService.getAllExpertsByCategory(categoryId);

      if (response.success && response.data != null) {
        _expertsByCategory[categoryTitle] = response.data!;
      } else {
        _expertsByCategory[categoryTitle] = [];
        showSnackBar("Error in fetching experts data", context, isError: true);
        throw Exception(response.message);
      }
    } catch (e) {
      _expertsByCategory[categoryTitle] = [];
      showSnackBar("Error : ${e.toString()}", context, isError: true);
      rethrow;
    } finally {
      _loadingStates[categoryTitle] = false;
      notifyListeners();
    }
  }

  void clearCategoryData(String categoryTitle) {
    _expertsByCategory.remove(categoryTitle);
    _loadingStates.remove(categoryTitle);
    notifyListeners();
  }

  void clearAllData() {
    _expertsByCategory.clear();
    _loadingStates.clear();
    notifyListeners();
  }

  //* Force reload category data
  Future<void> refreshCategoryData(
      String categoryTitle, BuildContext context) async {
    clearCategoryData(categoryTitle);
    await loadExpertsByCategory(categoryTitle, context);
  }
}
