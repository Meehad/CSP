import 'package:csp_dept/models/event_models.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class EventClass extends ChangeNotifier {
  List<EventModel> post = [];
  bool loading = false;

  Future<void> getEventList() async {
    try {
      final response = await http.get(showEvents, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        post = data.map((item) => EventModel.fromJson(item)).toList();
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
  }

  Future<void> getPostData() async {
    loading = true;
    await getEventList();
    loading = false;
    notifyListeners();
  }
}
