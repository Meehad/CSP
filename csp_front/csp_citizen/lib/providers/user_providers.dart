import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'UserName';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
