import 'package:flutter/material.dart';

class LoginLoadingpage extends StatefulWidget {
  LoginLoadingpage({Key key}) : super(key: key);

  @override
  _LoginLoadingpageState createState() => _LoginLoadingpageState();
}

class _LoginLoadingpageState extends State<LoginLoadingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
