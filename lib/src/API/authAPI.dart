import 'dart:convert';
import 'package:http/http.dart' as http;
class authAPI{
  Uri url = Uri.parse("http://18.218.101.141:3500/api/v1/auth/login");
  Future register(data) async{

    var response = await http.post(url,body: {
      'email':data['email'],
      'password':data['password'],
    });
    int statusCode = response.statusCode;
    var body = await jsonDecode(response.body);
    return {
      "statusCode": statusCode,
      "body":body ,
    };
  }
}