import 'dart:convert';

import 'package:http/http.dart' as http;
class studentAPI{
  static var url = Uri.parse("http://js-post-api.herokuapp.com/api/students?_sort=mark&_order=desc");
  static Future getStudent () async {
    var fetch= await http.get(url);
    var data = jsonDecode(fetch.body).sublist(0,5);
    return data;
  }
}