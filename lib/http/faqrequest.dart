import 'package:atamnirbharapp/utils/appconstant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class FaqHttpRequest {
  Future<List> mapDataToState(String tablename) async {
    Map<String, String> body = {'action': 'GET_ALL', 'table': tablename};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${AppContants.url}';
    http.Response response = await http
        .post('$url', body: body, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> jsondata = json.decode(response.body);
      return jsondata;
    }
  }
}
