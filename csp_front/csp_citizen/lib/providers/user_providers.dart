import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'xdgvh';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
