import 'package:acazia_training/models/user.dart';
import 'package:acazia_training/service/auth.dart';
import 'package:acazia_training/service/firestore_service.dart';
import 'package:acazia_training/ultis/error_dialog.dart';
import 'package:acazia_training/ultis/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CreateEmailViewModel{
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _buttonController = BehaviorSubject<bool>();

  Stream<String> get nameStream => _nameController.stream;
  Sink<String> get nameSink => _nameController.sink;

  Stream<String> get emailStream => _emailController.stream;
  Sink<String> get emailSink => _emailController.sink;

  Stream<bool> get btnStream => _buttonController.stream;
  Stream<bool> get insertButton {
    return CombineLatestStream.combine2(emailStream, nameStream, (email,name){
      return email.toString().isNotEmpty && name.toString().isNotEmpty;
    });
  }

  void submit(
      GlobalKey<FormState> formKey,
      TextEditingController nameController,
      TextEditingController emailController,
      FirebaseUser user,
      BuildContext context
      ){
    if(formKey.currentState.validate()){
      LoadingDialog.loading(context);
      AuthService()
          . createEmail(user,emailController.text).then((value){
        FireStoreService().createUser(
            User(
              id: user.uid,
              phone: user.phoneNumber,
              email: emailController.text,
              fullName: nameController.text,
            )
        );
      }).catchError((onError){
        ErrorDialog.showErrorDialog(onError, context);
      });
    }
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _buttonController.close();
  }
}