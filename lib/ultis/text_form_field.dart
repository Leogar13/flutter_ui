import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomTextFieldForm(
    TextEditingController nameController,
    String label,
    bool isEmail
    ){
  return TextFormField(
    validator: (value){
      if(isEmail){
        if(!value.contains('@')){
          return 'It\'s not email';
        }
      }
      return value.contains(' ')?'Do not use space': null;
    },
    controller: nameController,
    style: const TextStyle(
        color: Colors.white
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
      ),
    ),
  );
}