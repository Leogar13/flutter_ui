import 'package:acazia_training/models/head_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class CreatePhoneViewModel with ChangeNotifier{

  final _textController = BehaviorSubject<String>();
  final _buttonController = BehaviorSubject<bool>();

  Sink<String> get textSink => _textController.sink;

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

  //For dropdown
  static final List<HeadPhone> listHeadPhone = <HeadPhone>[
    HeadPhone(name: 'VN', key: '+84'),
    HeadPhone(name: 'UK', key: '+44'),
    HeadPhone(name: 'US', key: '+1')
  ];

  final List<DropdownMenuItem<HeadPhone>> dropMenu = listHeadPhone.map(
          (HeadPhone value)=>DropdownMenuItem<HeadPhone>(
            value: value,
            child: Text(value.name,),
      )
  ).toList();

  HeadPhone _selectedItem = listHeadPhone[0];

  List<DropdownMenuItem<HeadPhone>> get items => dropMenu;
  HeadPhone get selected => _selectedItem;

  void setSelectedItem(HeadPhone select) {
    _selectedItem = select;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.close();
    _buttonController.close();
  }
}