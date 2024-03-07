import 'package:csp_citizen/models/survey_model.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class SurveyQClass extends ChangeNotifier {
  SurveyQModel? post;
  bool loading = false;

  Future<SurveyQModel?> getSinglePostData() async {
    SurveyQModel? eventList;
    try {
      final response = await http.get(showfeeds, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        eventList = SurveyQModel.fromJson(item);
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