import 'package:connect/http/models/model_user.dart';
import 'package:connect/http/models/model_expert.dart';
import 'package:connect/http/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isInitialized = false;
  bool _expertsInitialized = false;

  UserModel? _userModel;
  List<ExpertModel>? _expertsList;

  bool _isUserLoading = true;
  bool _isExpertsLoading = false;

  String? _userErrorMessage;
  String? _expertsErrorMessage;

  bool get isInitialized => _isInitialized;

  set isInitialized(bool value) {
    if (_isInitialized != value) {
      _isInitialized = value;
      notifyListeners();
    }
  }

  bool get expertsInitialized => _expertsInitialized;

  set expertsInitialized(bool value) {
    if (_expertsInitialized != value) {
      _expertsInitialized = value;
      notifyListeners();
    }
  }

  UserModel? get userModel => _userModel;

  set userModel(UserModel? value) {
    if (_userModel != value) {
      _userModel = value;
      notifyListeners();
    }
  }

  List<ExpertModel>? get expertsList => _expertsList;

  set expertsList(List<ExpertModel>? value) {
    if (_expertsList != value) {
      _expertsList = value;
      notifyListeners();
    }
  }

  bool get isUserLoading => _isUserLoading;
  bool get isExpertsLoading => _isExpertsLoading;
  String? get userErrorMessage => _userErrorMessage;
  String? get expertsErrorMessage => _expertsErrorMessage;

  set _setUserLoading(bool value) {
    if (_isUserLoading != value) {
      _isUserLoading = value;
      notifyListeners();
    }
  }

  set _setExpertsLoading(bool value) {
    if (_isExpertsLoading != value) {
      _isExpertsLoading = value;
      notifyListeners();
    }
  }

  set _setUserErrorMessage(String? value) {
    if (_userErrorMessage != value) {
      _userErrorMessage = value;
      notifyListeners();
    }
  }

  set _setExpertsErrorMessage(String? value) {
    if (_expertsErrorMessage != value) {
      _expertsErrorMessage = value;
      notifyListeners();
    }
  }

  Future<void> initializeUser() async {
    if (_isInitialized) {
      return;
    }

    try {
      _setUserLoading = true;
      _setUserErrorMessage = null;

      final response = await _userService.getUserStats();

      if (response.success && response.data != null) {
        userModel = response.data;
        storeWalletBalance(userModel?.walletBalance ?? 0.0);
        isInitialized = true;
        _setUserErrorMessage = null;
      } else {
        _setUserErrorMessage = response.message;
        userModel = null;
        isInitialized = false;
      }
    } catch (e) {
      _setUserErrorMessage = 'Error initializing user: ${e.toString()}';
      userModel = null;
      isInitialized = false;
    } finally {
      _setUserLoading = false;
    }
  }

  Future<void> initializeExperts() async {
    if (_expertsInitialized) {
      return;
    }

    try {
      _setExpertsLoading = true;
      _setExpertsErrorMessage = null;

      final response = await _userService.getAllExperts();

      if (response.success && response.data != null) {
        expertsList = response.data;
        expertsInitialized = true;
        _setExpertsErrorMessage = null;
      } else {
        _setExpertsErrorMessage = response.message;
        expertsList = null;
        expertsInitialized = false;
      }
    } catch (e) {
      _setExpertsErrorMessage = 'Error initializing experts: ${e.toString()}';
      expertsList = null;
      expertsInitialized = false;
    } finally {
      _setExpertsLoading = false;
    }
  }

  Future<void> refreshUserData() async {
    try {
      _setUserLoading = true;
      _setUserErrorMessage = null;

      final response = await _userService.getUserStats();

      if (response.success && response.data != null) {
        userModel = response.data;
        storeWalletBalance(userModel?.walletBalance ?? 0.0);
        _setUserErrorMessage = null;
      } else {
        _setUserErrorMessage = response.message;
      }
    } catch (e) {
      _setUserErrorMessage = 'Error refreshing user: ${e.toString()}';
    } finally {
      _setUserLoading = false;
    }
  }

  Future<void> refreshExperts() async {
    try {
      _setExpertsLoading = true;
      _setExpertsErrorMessage = null;

      final response = await _userService.getAllExperts();

      if (response.success && response.data != null) {
        expertsList = response.data;
        _setExpertsErrorMessage = null;
      } else {
        _setExpertsErrorMessage = response.message;
      }
    } catch (e) {
      _setExpertsErrorMessage = 'Error refreshing experts: ${e.toString()}';
    } finally {
      _setExpertsLoading = false;
    }
  }

  //* Store user amount in SharedPreferences
  Future<void> storeWalletBalance(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('wallet_balance', amount);
  }
}
