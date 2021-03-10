import 'package:acazia_training/navigation/navigation.dart';
import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/service/auth.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:flutter/material.dart';

class SucceedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: COLOR_BACKGROUND,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: (){
                  AuthService().signOut();
                  Navigation.instance
                      .navigateAndRemove(SIGN_UP,arguments: null);
                  },
            ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  StringFinal().completeNamePage,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
