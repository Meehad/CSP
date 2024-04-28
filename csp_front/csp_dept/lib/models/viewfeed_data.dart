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
    try {
      final response = await http.get(showfeeds(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedModel.fromJson(jsonData);
      } else {
        Fluttertoast.showToast(
          msg: 'No Feedbacks yet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching post data: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Handle error gracefully, e.g., return null or throw an exception
    }
    return null;
  }

  Future<List<FeedModel>> getPostData(String id) async {
    try {
      final response = await http.get(showfeeds(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonDataList = json.decode(response.body);
        List<FeedModel> feedModels = [];
        for (var jsonData in jsonDataList) {
          feedModels.add(FeedModel.fromJson(jsonData));
        }
        return feedModels;
      } else {
        Fluttertoast.showToast(
          msg: 'No Feedbacks yet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching post data: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Handle error gracefully, e.g., throw an exception
      throw Exception('Failed to load post data');
    }
  }
}

class AvgFeedClass extends ChangeNotifier {
  AvgFeedModel? post;
  bool loading = false;

  Future<void> getSinglePostData(String id) async {
    try {
      loading = true; // Set loading to true before making the request
      notifyListeners(); // Notify listeners after changing the loading state

      final response = await http.get(showavgfeed(id), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        post = AvgFeedModel.fromJson(item);
      } else {
        Fluttertoast.showToast(
          msg: 'No Feedbacks yet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loading =
          false; // Set loading to false after the request completes (whether successful or not)
      notifyListeners(); // Notify listeners after changing the loading state
    }
  }

  void getPostData(String id) async {
    await getSinglePostData(id);
  }
}
