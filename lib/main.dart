import 'package:acazia_training/navigation/navigation.dart';
import 'package:acazia_training/navigation/routes.dart';
import 'package:acazia_training/service/auth.dart';
import 'package:acazia_training/service/wrapper.dart';
import 'package:acazia_training/view/pages/create_account_page_email_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          navigatorKey: Navigation().navigatorKey,
          onGenerateRoute: generateRoute,
          theme: ThemeData(
              canvasColor: Colors.black,
              primarySwatch: Colors.blue,
              inputDecorationTheme: const InputDecorationTheme(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              )
          ),
          home: Wrapper()
      ),
    );
  }
}

