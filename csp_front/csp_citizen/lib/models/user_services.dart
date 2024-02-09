import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:csp_citizen/models/user_models.dart';
import 'package:http/http.dart' as http;

Future<UserModel?> getSinglePostData() async {
  UserModel? result;
  try {
    final response = await http
        .get(Uri.parse("http://10.0.2.2:8000/adm/1/showprofile/"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = UserModel.fromJson(item);
    } else {
      print('error');
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
