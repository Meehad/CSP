import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class EventClass extends ChangeNotifier {
  bool loading = false;
  List<EventModel> eventList = [];

  Future<void> getSinglePostData(String id) async {
    try {
      final response = await http.get(showunfeeded(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        eventList = (item as List).map((e) => EventModel.fromJson(e)).toList();
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

  getPostData(String id) async {
    loading = true;
    await getSinglePostData(id);
    loading = false;

    notifyListeners();
  }
}