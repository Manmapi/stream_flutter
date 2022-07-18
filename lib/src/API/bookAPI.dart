import 'dart:convert';

import 'package:http/http.dart' as http;
class bookRequest{
  static var url= Uri.parse("http://18.218.101.141:3500/api/v1/book/");
  Future fetchBook () async {
    var response = await http.get(url);
    var jsonData = await jsonDecode(response.body);
    return jsonData;
  }
}

