// ignore_for_file: non_constant_identifier_names

import 'package:csp_citizen/models/user_models.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class DataClass extends ChangeNotifier {
  UserModel? post;
  bool loading = false;
  String id_num;

  DataClass({this.id_num = ""});

  void changeId({required String new_id_num}) async {
    id_num = new_id_num;
  }

  Future<UserModel?> getSinglePostData({required String id_num}) async {
    UserModel? result;
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8000/csp_log/$id_num/showprofile/"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          });
      notifyListeners();
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

  getPostData() async {
    loading = true;
    post = (await getSinglePostData(id_num: id_num))!;
    loading = false;

    notifyListeners();
  }
}
