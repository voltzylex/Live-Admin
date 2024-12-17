import 'dart:convert';

import 'package:get/get.dart';
import 'package:live_admin/app/modules/auth_module/controllers/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SC extends GetxController {
  // Singleton instance
  static final SC to = SC._();

  SC._(); // Private constructor

  // Rx variables for user data
  RxBool isUserLoggedIn = false.obs;
  RxString username = ''.obs;

  // Method to initialize SharedPreferences
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save login status to SharedPreferences
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    isUserLoggedIn.value = isLoggedIn;
  }

  // Save username to SharedPreferences
  Future<void> saveUser(LoginModel user) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setString('user', jsonEncode(user.toJson()));
    saveLoginStatus(true);
    username.value = user.admin?.name ?? "User";
  }

  Future<LoginModel?> getUser() async {
    SharedPreferences prefs = await _getPrefs();
    final user = prefs.getString('user');

    return user != null ? LoginModel.fromJson(jsonDecode(user)) : null;
  }

  Future<String?> getToken() async {
    return (await getUser())?.accessToken;
  }

  // Retrieve login status from SharedPreferences
  Future<bool> loadLoginStatus() async {
    SharedPreferences prefs = await _getPrefs();

    isUserLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    return isUserLoggedIn.value;
  }

  // Retrieve username from SharedPreferences
  Future<void> loadUsername() async {
    SharedPreferences prefs = await _getPrefs();
    username.value = prefs.getString('username') ?? '';
  }

  // Clear SharedPreferences data (e.g., logout)
  Future<void> clearUserData() async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');
    isUserLoggedIn.value = false;
    username.value = '';
  }
}
