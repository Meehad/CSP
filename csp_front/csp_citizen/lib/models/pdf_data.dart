// ignore_for_file: camel_case_types

import 'package:csp_citizen/models/pdf_model.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class pdfClass extends ChangeNotifier {
  pdfModel? post;
  bool loading = false;

  Future<pdfModel?> getSinglePostData() async {
    pdfModel? eventList;
    try {
      final response = await http.get(showfeeds, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List) {
          // Assuming you want to handle a list of items
          if (jsonResponse.isNotEmpty) {
            // Choose a specific element from the list or iterate through it
            eventList = pdfModel.fromJson(jsonResponse[0]);
          }
        } else if (jsonResponse is Map<String, dynamic>) {
          // Assuming it's a single item
          eventList = pdfModel.fromJson(jsonResponse);
        }
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
    return eventList;
  }

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}
