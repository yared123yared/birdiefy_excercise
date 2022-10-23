import 'dart:convert';
import 'package:app/model/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class UserPreferences {
  Future<void> storeUserInformation(UserEntity info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(info));
  }

  Future<void> logOut( bool loggedOut)async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('logout', loggedOut);
  }

  Future<bool?> IsLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('logout');
  }

  Future<UserEntity?> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? u_info = prefs.getString('user');
    if (u_info != null) {
      Map<String, dynamic> json = jsonDecode(u_info) as Map<String, dynamic>;
      var user = UserEntity.fromJson(json);
      return user;
    }
    return null;
  }

  Future<void> storeTokenAndExpiration(String token, String expiry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('storing token 1');
    print(token);
    await prefs.setString('token', token);
    await prefs.setString('expiry', expiry);
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('storing token 2');
    // print(token);
    await prefs.setString('token', token);
  }

  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}