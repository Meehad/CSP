// ignore_for_file: non_constant_identifier_names

import 'package:csp_citizen/models/user_models.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        showProfile(id_num),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        return UserModel.fromJson(item);
      } else {
        Fluttertoast.showToast(
          msg: 'Error fetching user data. Status code: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
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
