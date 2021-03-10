import 'package:acazia_training/models/head_phone.dart';
import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:acazia_training/ultis/text_style.dart';
import 'package:acazia_training/view_model/create_phone_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:acazia_training/navigation/navigation.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class CreateAccountPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BACKGROUND,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: ChangeNotifierProvider(
          create: (_) => CreatePhoneViewModel(),
          child: BodyWidget(),
        )
    )
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget>  {
  String verificationId, smsCode;
  String _phoneNumber;
  HeadPhone _selected;
  final _myController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _selected = Provider.of<CreatePhoneViewModel>(context, listen: false)
        .selected;

    //listener
    _myController.addListener((){
      Provider.of<CreatePhoneViewModel>(context, listen: false)
          .textSink.add(_myController.text);

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BACKGROUND,
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                StringFinal().createAccountNamePage,
                style: TextStyleFinal.pageTitle,
              ),
              Row(
                children: <Widget>[
                  Consumer<CreatePhoneViewModel>(
                    builder: (context, myModel, child){
                      return DropdownButton<HeadPhone>(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        value: _selected,
                        items: myModel.dropMenu,
                        onChanged: (value){
                          myModel.setSelectedItem(value);
                          _selected = value;
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      cursorColor: Colors.white,
                      controller: _myController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                        hintText: StringFinal().createPhoneAccountHint,
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                          Navigation.instance.navigateTo(
                            LOGIN,
                            arguments: null
                          );
                      },
                      child: Text(
                        StringFinal().createPhoneAccountSignInBtn,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    StreamBuilder(
                          initialData: false,
                          stream: Provider
                              .of<CreatePhoneViewModel>(context,listen: false)
                              .insertButton,
                          builder: (context, snapshot){
                            return IconButton(
                              padding: const
                              EdgeInsets.only(right: 20, bottom: 20),
                              onPressed: snapshot.data ?(){
                                _phoneNumber =
                                '${_selected.key} ${_myController.text}';
                                //hide the keyboard
                                SystemChannels.
                                textInput.invokeMethod('TextInput.hide');
                                Navigation.instance.navigateTo(
                                    VERIFICATION_CODE,
                                    arguments: _phoneNumber
                                );
                              } : null,
                              icon: FaIcon(FontAwesomeIcons.arrowCircleRight),
                              iconSize: 50,
                              disabledColor: Colors.grey,
                              color: Colors.white,
                            );
                          },
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


