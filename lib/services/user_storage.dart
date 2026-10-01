import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserStorage {
  static const _userKey = 'logged_user';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode({
      'id':user.id,
      'name':user.name,
      'email':user.email,
      'role':user.role
    }));
  }
  Future<User?> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if(raw == null) return null;
    return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}