import 'dart:convert';

import 'package:corona_app/Data/models/corona_country.dart';
import 'package:corona_app/Data/models/corona_summary.dart';
import 'package:corona_app/res/strings/app_string.dart';
import 'package:http/http.dart' as http;

class CoronaSource {
  Future<CoronaSummary> getCoronaSummary() async {
    var response = await http.get(AppString.corona_summary_url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      CoronaSummary coronaSummary = CoronaSummary.fromJson(data);
      return coronaSummary;
    } else {
      throw Exception();
    }
  }

  Future<List<CoronaCountry>> getCoronaCountries() async {
    var response = await http.get(AppString.corona_countries_url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<CoronaCountry> countries =
          CoronaCountryList.fromJson(data).countries;
      return countries;
    } else {
      throw Exception();
    }
  }

  List<CoronaCountry> getFilterCountries(
      String text, List<CoronaCountry> countries) {
    if (text.length == 0) {
      return [];
    } else {
      List<CoronaCountry> list = countries.where((element) =>
          element.country.toLowerCase().contains(text.trim().toLowerCase()));
      return list;
    }
  }
}
