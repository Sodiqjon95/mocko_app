import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:mocko_app/models/company_item.dart';

class ApiProvider {
  static Future<List<CompanyItem>> getAllCompanies() async {
    try {
      https.Response response = await https.get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return (jsonDecode(response.body)['data'] as List?)?.map((e) => CompanyItem.fromJson(e)).toList() ?? [];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<CompanyItem> getSingleCompany({
  required int id
}) async {
    try {
      https.Response response = await https.get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies/$id"));
      if (response.statusCode == 200) {
        return  CompanyItem.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
