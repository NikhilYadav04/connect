import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static Future<double?> getWalletAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('wallet_balance');
  }
}
