import 'package:csp_dept/models/survey_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class SurveyClass extends ChangeNotifier {
  SurveyModel? post;
  bool loading = false;

  Future<SurveyModel?> getSinglePostData() async {
    SurveyModel? eventList;
    try {
      final response = await http.get(showans, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        eventList = SurveyModel.fromJson(item);
      } else {
        print('error');
      }
    } catch (e) {
      log(e.toString());
    }
    return eventList;
  }

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}
