import 'dart:convert';
import 'dart:developer';

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

  SharedPreferences? _prefs;

  // Initialize SharedPreferences (call this during app initialization)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    loadLoginStatus(); // Preload login status
    loadUsername(); // Preload username
  }

  // Save login status to SharedPreferences
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    try {
      await _prefs?.setBool('isLoggedIn', isLoggedIn);
      isUserLoggedIn.value = isLoggedIn;
    } catch (e) {
      log("Error saving login status: $e");
    }
  }

  // Save user to SharedPreferences
  Future<void> saveUser(LoginModel user) async {
    try {
      await _prefs?.setString('user', jsonEncode(user.toJson()));
      saveLoginStatus(true); // Automatically update login status
      username.value = user.admin?.name ?? "User";
    } catch (e) {
      log("Error saving user: $e");
    }
  }

  // Get user from SharedPreferences
  Future<LoginModel?> getUser() async {
    try {
      final user = _prefs?.getString('user');
      return user != null ? LoginModel.fromJson(jsonDecode(user)) : null;
    } catch (e) {
      log("Error retrieving user: $e");
      return null;
    }
  }

  // Get token from user
  Future<String?> getToken() async {
    try {
      final token = (await getUser())?.accessToken;
      log("Token: $token");
      return token;
    } catch (e) {
      log("Error retrieving token: $e");
      return null;
    }
  }

  // Retrieve login status from SharedPreferences
  Future<void> loadLoginStatus() async {
    try {
      isUserLoggedIn.value = _prefs?.getBool('isLoggedIn') ?? false;
    } catch (e) {
      log("Error loading login status: $e");
    }
  }

  // Retrieve username from SharedPreferences
  void loadUsername() {
    try {
      username.value = _prefs?.getString('username') ?? '';
    } catch (e) {
      log("Error loading username: $e");
    }
  }

  // Clear SharedPreferences data (e.g., logout)
  Future<void> clearUserData() async {
    try {
      await _prefs?.remove('isLoggedIn');
      await _prefs?.remove('user');
      isUserLoggedIn.value = false;
      username.value = '';
    } catch (e) {
      log("Error clearing user data: $e");
    }
  }
}
