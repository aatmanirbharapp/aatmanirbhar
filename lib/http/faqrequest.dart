import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/utils/appconstant.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SqlResponse {
  var repo = CompanyRepository();

  Future<List> searchByCompany() async {
    http.Response response = await http
        .get(AppContants.company, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List jsondata = json.decode(response.body);

      return jsondata;
    } else {
      return List.empty();
    }
  }

  Future<List> searchByProduct() async {
    http.Response response = await http
        .get(AppContants.product, headers: {"Accept": "application/json"});

    print(response.statusCode);

    if (response.statusCode == 200) {
      List jsondata = json.decode(response.body);
      return jsondata;
    } else {
      return List.empty();
    }
  }

  Future<List> getRatingById(String id) async {
    Map<String, String> body = {
      'action': 'GET_RATING_BY_ID',
      'table': 'ratings',
      'id': id
    };

    http.Response response = await http.post('${AppContants.url}',
        body: body, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> jsondata = json.decode(response.body);
      return jsondata;
    } else {
      return List.empty();
    }
  }

  Future<List> getRatingCount(String id) async {
    Map<String, String> body = {
      'action': 'GET_RATING_COUNT',
      'table': 'ratings',
      'id': id
    };

    http.Response response = await http.post('${AppContants.url}',
        body: body, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> jsondata = json.decode(response.body);
      return jsondata;
    } else {
      return List.empty();
    }
  }

  Future<List> addRating(
      String userid,
      String productid,
      String companyid,
      double rating,
      String time,
      String title,
      String description,
      String username) async {
    Map<String, Object> body = {
      'action': 'ADD_RATING',
      'table': 'ratings',
      'rating': rating,
      'userid': userid,
      'companyid': companyid,
      'productid': productid,
      'title': title,
      'description': description,
      'time': time,
      'username': username
    };

    http.Response response = await http.post('${AppContants.url}',
        body: body, headers: {"Accept": "application/json"});
    await getRatingCount(companyid);
    repo.updateRatingCompany(companyid, '4.0');

    if (response.statusCode == 200) {
      List<dynamic> jsondata = json.decode(response.body);
      return jsondata;
    } else {
      return List.empty();
    }
  }
}
