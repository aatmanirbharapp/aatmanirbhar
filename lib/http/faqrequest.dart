import 'package:atamnirbharapp/utils/appconstant.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SqlResponse {
  Future<List> searchByCompany(String tablename, String search) async {
    Map<String, String> body = {
      'action': 'SEARCH_COMPANY_LIKE',
      'table': tablename,
      'search': search
    };

    http.Response response = await http.post('${AppContants.url}',
        body: body, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> jsondata = json.decode(response.body);
      return jsondata;
    } else {
      return List();
    }
  }
}
