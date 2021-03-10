import 'package:acazia_training/ultis/extensions/time_format.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

Stream<String> CountString (){
  int start = 30;
  return Stream<String>.periodic(const Duration(seconds: 1),(value){
    start--;
    return start.formatMMSS();
  });
}

class VerificationViewModel{
  final _textController = BehaviorSubject<String>();
  final _buttonController = BehaviorSubject<bool>();

  Sink<String> get textSink => _textController.sink;

  Stream<bool> get insertButton {
    return CombineLatestStream(
      [_textController],
          (values) {
        if(values.toString().length < 8) {
          return false;
        }else {
          return true;
        }
      },
    );
  }

  void dispose() {
    _textController.close();
    _buttonController.close();
  }
}