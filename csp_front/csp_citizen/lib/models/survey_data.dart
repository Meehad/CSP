import 'package:csp_citizen/models/survey_model.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class Qlist extends ChangeNotifier {
  List<SurveyQModel> qlist = [];
  bool loading = false;

  Future<void> getSinglePostData(String id) async {
    try {
      final response = await http.get(showRQ(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        qlist = (item as List).map((e) => SurveyQModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getPostData(String id) async {
    loading = true;
    notifyListeners();
    await getSinglePostData(id);
    loading = false;
    notifyListeners();
  }

  void addData(SurveyQModel data) {
    loading = true;
    qlist.add(data);
    loading = false;
    notifyListeners();
  }

  void removeData(int index) {
    loading = true;
    notifyListeners();
    qlist.removeAt(index);
    loading = false;
    notifyListeners();
  }
}