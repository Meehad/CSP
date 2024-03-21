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

  Future<SurveyModel?> getSinglePostData(String id) async {
    try {
      final response = await http.get(showans(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        return SurveyModel.fromJson(item);
      } else {
        log('Error: ${response.statusCode}');
        // Handle error cases more explicitly if needed
        return null;
      }
    } catch (e) {
      log(e.toString());
      // Handle network or other errors more explicitly if needed
      return null;
    }
  }

  Future<void> getPostData(String id) async {
    loading = true;
    post = await getSinglePostData(id);
    loading = false;

    notifyListeners();
  }
}

class SurveyDataProvider extends ChangeNotifier {
  List<SurveyOptions> _surveyData = [];
  bool _isLoading = false;

  List<SurveyOptions> get surveyData => _surveyData;
  bool get isLoading => _isLoading;

  Future<void> fetchSurveyData(String departmentName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(showop(departmentName));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _surveyData = data.map((json) => SurveyOptions.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load survey data');
      }
    } catch (e) {
      log('Error fetching survey data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}