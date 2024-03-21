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

  void changeId({required String new_id_num}) {
    id_num = new_id_num;
  }

  Future<UserModel?> getSinglePostData({required String id_num}) async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.0.187:8000/csp_log/$id_num/showprofile/"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        return UserModel.fromJson(item);
      } else {
        print('Error fetching user data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
  }

  Future<void> getPostData() async {
    loading = true;
    try {
      post = await getSinglePostData(id_num: id_num);
      loading = false;
      notifyListeners(); // Move the notifyListeners outside of the asynchronous block
    } catch (e) {
      loading = false;
      log(e.toString());
    }
  }
}
