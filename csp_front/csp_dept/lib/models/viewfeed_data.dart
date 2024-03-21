import 'package:csp_dept/models/viewfeed_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class FeedClass extends ChangeNotifier {
  FeedModel? post;
  bool loading = false;

  Future<FeedModel?> getSinglePostData(String id) async {
    FeedModel? eventList;
    try {
      final response = await http.get(showfeeds(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        eventList = FeedModel.fromJson(item);
      } else {
        Fluttertoast.showToast(
          msg: 'No Feedbacks yet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return eventList;
  }

  getPostData(String id) async {
    loading = true;
    post = (await getSinglePostData(id))!;
    loading = false;

    notifyListeners();
  }
}

class AvgFeedClass extends ChangeNotifier {
  AvgFeedModel? post;
  bool loading = false;

  Future<AvgFeedModel?> getSinglePostData(String id) async {
    AvgFeedModel? eventList;
    try {
      final response = await http.get(showavgfeed(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        eventList = AvgFeedModel.fromJson(item);
      } else {
        Fluttertoast.showToast(
          msg: 'No Feedbacks yet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return eventList;
  }

  getPostData(String id) async {
    loading = true;
    notifyListeners();
    post = (await getSinglePostData(id))!;
    loading = false;
    notifyListeners();
  }
}
