import 'package:csp_citizen/models/user_models.dart';
import 'package:csp_citizen/models/user_services.dart';
import 'package:flutter/material.dart';

class DataClass extends ChangeNotifier {
  UserModel? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}
