import 'dart:convert';
import 'package:first_app/users/authentication/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  // Save-Remember User-Info
  static Future<void> storeUserInfo(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  // Get-Read User-Info
  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");
    if (userInfo != null) {
      try {
        Map<String, dynamic> userDataMap = jsonDecode(userInfo);
        currentUserInfo = User.fromJson(userDataMap);
      } catch (e) {
        print("Error decoding user information: $e");
      }
    }
    return currentUserInfo;
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
