import 'package:flutter/foundation.dart';

class SignInProvider extends ChangeNotifier {
  String _token;

  void setTokenId(String token) {
    this._token = token;
    // notifyListeners();
  }

  String get getTokenId => this._token;
}
