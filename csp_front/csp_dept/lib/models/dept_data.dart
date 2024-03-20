// ignore_for_file: non_constant_identifier_names

import 'package:csp_dept/models/dept_models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class DeptDataClass extends ChangeNotifier {
  DeptModel? post;
  bool loading = false;
  String dept_id;

  DeptDataClass({this.dept_id = ""});

  void changeId({required String new_id_num}) async {
    dept_id = new_id_num;
  }

  Future<DeptModel?> getSinglePostData({required String dept_id}) async {
    DeptModel? result;
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8000/csp_log/$dept_id/showdeptprofile/"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = DeptModel.fromJson(item);
      } else {
        Fluttertoast.showToast(
        msg: 'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  getPostData() async {
    loading = true;
    post = (await getSinglePostData(dept_id: dept_id))!;
    loading = false;

    notifyListeners();
  }
}