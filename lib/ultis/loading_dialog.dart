import 'package:flutter/material.dart';

class LoadingDialog{
  static void loading(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return const AlertDialog(
            title: Text('Loading...'),
            actions: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.red,
              ),
            ],
          );
        }
    );
  }
}