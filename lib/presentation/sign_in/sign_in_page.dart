import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_apps/application/sign_in/sign_in_provider.dart';
import 'package:vegetable_apps/domain/authentication/auth_repository.dart';
import 'package:vegetable_apps/domain/authentication/value_objects.dart';
import 'package:vegetable_apps/presentation/core/login_loading_page.dart';
import 'package:vegetable_apps/presentation/menu_list/menu_list_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obsecureText;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  Dio _dio;
  bool _isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    _dio = Dio();
    _obsecureText = true;
    _isLoading = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignInProvider>(
        builder: (context, singInProvider, _) => SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecureText,
                    validator: validatePassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock_open,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (_obsecureText == false)
                              _obsecureText = true;
                            else
                              _obsecureText = false;

                            setState(() {});
                          },
                          child: Icon((_obsecureText == false)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off)),
                      hintText: "Passwrod",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Register Here",
                          style: TextStyle(
                              color: Colors.purple[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: FlatButton(
                      splashColor: Colors.white,
                      color: Colors.black87,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () async {
                        try {
                          await _validateAuthentication(singInProvider);
                        } on Exception catch (_) {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text("error"),
                              children: <Widget>[Text(_.toString())],
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAuthentication(SignInProvider signInProvider) {
    if (_formKey.currentState.validate()) {
      AuthRepository authRepository = AuthRepository();
      _isLoading = true;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginLoadingpage();
      }));

      authRepository
          .signInUser(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MenuListPage(token: value);
        }));

        //set nilai ke dalam provider.

        signInProvider.setTokenId(value);
      }).catchError((error) => print("error"));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
