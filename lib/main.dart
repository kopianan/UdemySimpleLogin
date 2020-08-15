import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_apps/application/sign_in/sign_in_provider.dart';

import 'presentation/app_widget.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SignInProvider(),
    ),
  ], child: AppWidget()));
}
