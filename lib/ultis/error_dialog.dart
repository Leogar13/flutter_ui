import 'package:flutter/material.dart';

class ErrorDialog{
  static void showErrorDialog(String onError, BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(onError.toString()),
          );
        }
    );
  }
}