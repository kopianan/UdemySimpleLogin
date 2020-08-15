import 'package:flutter/material.dart';

import 'sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInPage());
  }
}
