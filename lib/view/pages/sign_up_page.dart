import 'package:acazia_training/navigation/navigation.dart';
import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:acazia_training/ultis/text_style.dart';
import 'package:acazia_training/view_model/signup_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  BodyWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget>
    with SingleTickerProviderStateMixin {

  Widget startPhoneNumber = Text(
    StringFinal().signUpPagePhoneNumberBtn,
    style: const TextStyle(
        color: Colors.white,
        fontSize: 17
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BACKGROUND,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
                child: Text(
                  StringFinal().signUpNamePage,
                  style: TextStyleFinal.pageTitle,
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,50,10,50),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: ()=>Provider
                        .of<SignUpViewModel>(context,listen: false).login(),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FaIcon(
                            FontAwesomeIcons.facebookSquare,
                            color: const Color(0xff3C5E9E),
                          ),
                        ),
                        Text(
                          StringFinal().signUpPageFacebookBtn,
                          style: const TextStyle(
                            color: Color(0xff3C5E9E),
                            fontSize: 17
                          ),
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: OutlineButton(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      padding: const EdgeInsets.all(20),
                      onPressed: ()=>
                        Navigation.instance.navigateTo(CREATE_ACCOUNT_PHONE,
                            arguments: null),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           startPhoneNumber,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: StringFinal().signUpPageLoginText,
                      ),
                      TextSpan(
                        text: StringFinal().signUpPageLoginBtn,
                        style: TextStyle(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = ()=>
                        Navigation.instance.navigateTo(LOGIN,arguments: null),
                      )
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
