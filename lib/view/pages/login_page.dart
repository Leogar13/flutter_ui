import 'package:acazia_training/navigation/navigation.dart';
import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:acazia_training/ultis/text_form_field.dart';
import 'package:acazia_training/ultis/text_style.dart';
import 'package:acazia_training/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogInViewModel>(
      create: (_)=>LogInViewModel(),
      child: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool _isPhone = false;

  final _button = <Widget>[
    FlatButton(
      onPressed: ()=>
          Navigation.instance.navigateTo(CREATE_ACCOUNT_PHONE,arguments: null),
      child: Text(
        StringFinal().loginSignUpBtn,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    FlatButton(
      onPressed: (){},
      child: Text(
        StringFinal().loginForgotPasswordBtn,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ];

  @override
  void initState(){
    super.initState();
    _textController.addListener((){
      Provider.of<LogInViewModel>(context, listen: false)
          .textSink.add(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_BACKGROUND,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  StringFinal().loginNamePage,
                  style: TextStyleFinal.pageTitle,
                ),
                StreamBuilder(
                  initialData: StringFinal().loginHint,
                  stream: Provider.of<LogInViewModel>(context).textStream,
                  builder: (context, snapshot){
                    return Consumer<LogInViewModel>(
                      builder: (context,myModel,child){
                        if(snapshot.data.toString().contains('Phone')){
                          _isPhone=true;
                        }else{
                          _isPhone=false;
                        }
                        return CustomTextFieldForm(
                            _textController,
                            snapshot.data,
                            false);
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _button,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: StreamBuilder(
                    initialData: false,
                    stream: Provider.of<LogInViewModel>(context).insertButton,
                    builder:(context, snapshot){
                      return IconButton(
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        onPressed: snapshot.data ?
                        ()=> Provider
                            .of<LogInViewModel>(context,listen: false).submit(
                            formKey,
                            context,
                            _textController,
                            _isPhone
                        )
                        : null,
                        icon: FaIcon(FontAwesomeIcons.arrowCircleRight),
                        iconSize: 50,
                        disabledColor: Colors.grey,
                        color: Colors.white,
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



