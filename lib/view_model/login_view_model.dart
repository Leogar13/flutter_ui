import 'package:acazia_training/models/validation.dart';
import 'package:acazia_training/service/auth.dart';
import 'package:acazia_training/ultis/error_dialog.dart';
import 'package:acazia_training/ultis/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LogInViewModel with ChangeNotifier{
  final _textController = BehaviorSubject<String>();

  Sink<String> get textSink => _textController.sink;
  Stream<String> get textStream {
    return CombineLatestStream(
        [_textController],
            (value){
          final _result = value.toString()
              .substring(1,value.toString().length-1);
          return Validation.phoneNumber(_result)?'Phone':'Email';
        }
    );
  }

  Stream<bool> get insertButton {
    return CombineLatestStream(
      [_textController],
          (values) {
        if(values.toString().length < 3) {
          return false;
        }else {
          return true;
        }
      },
    );
  }

  void submit(
      GlobalKey<FormState> formKey,
      BuildContext context,
      TextEditingController textController,
      bool isPhone
      ){
    if(formKey.currentState.validate()){
      LoadingDialog.loading(context);
      try
      {
        if(isPhone){
          AuthService().submitPhoneNumber(textController.text,30);
        }else{
          AuthService().signInByEmail(textController.text, context);
        }
      }catch(e){
        ErrorDialog.showErrorDialog(e, context);
      }
    }
  }

  @override
  void dispose(){
    super.dispose();
    _textController.close();
  }
}