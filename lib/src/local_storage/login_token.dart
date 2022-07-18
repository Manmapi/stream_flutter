import 'package:shared_preferences/shared_preferences.dart';

class UserToken{
  static setToken (String token) async{

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }
  static getToken () async{

    final prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('token');

    return token;


  }
  static getCreateAt() async {

    final prefs = await SharedPreferences.getInstance();

    int? createdAt = await prefs.getInt('createAt');
    return createdAt;
  }
  static setCreateAt() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('createAt',DateTime.now().millisecondsSinceEpoch);
  }
}