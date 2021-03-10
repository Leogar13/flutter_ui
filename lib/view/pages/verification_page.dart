import 'dart:async';
import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/service/auth.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:acazia_training/ultis/text_style.dart';
import 'package:acazia_training/view_model/verification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage(
      {Key key, this.phoneNumber}
      ) : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Provider<VerificationViewModel>(
      create: (_) => VerificationViewModel(),
      child: Scaffold(
        body: BodyWidget(
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget(
      {Key key, this.phoneNumber}
      ) : super(key: key);
  final String phoneNumber;
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  bool _turnPage = false;
  String verificationId;
  final _pinCode = TextEditingController();

  Future showOverlay(BuildContext context) async{
    final OverlayState overlayState = Overlay.of(context);
    final OverlayEntry overlayEntry = OverlayEntry(
        builder: (context)=> Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              height: 80,
              color: Colors.red,
              child: Center(
                child: Text(
                  StringFinal().verificationPageIncorrectOverlay ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            )
        )
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 1));
    overlayEntry.remove();
  }

  @override
  void initState(){
    super.initState();
    AuthService().submitPhoneNumber(widget.phoneNumber,0);

    _pinCode.addListener((){
      Provider.of<VerificationViewModel>(context, listen: false)
          .textSink.add(_pinCode.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BACKGROUND,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                StringFinal().verificationNamePage,
                style: TextStyleFinal.pageTitle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StringFinal().verificationPageEnterCodeText  ,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                    widget.phoneNumber,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: PinCodeTextField(
                    controller: _pinCode,
                    autoFocus: true,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    inactiveColor: const Color(0xffD8D8D8),
                    selectedColor: const Color(0xffD8D8D8),
                    activeColor: const Color(0xffD8D8D8),
                    textInputType: TextInputType.number,
                    backgroundColor: Colors.transparent,
                    length: 6,
                    onChanged: (String value){},
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StreamBuilder(
                        initialData: '00:30',
                        stream: CountString(),
                        builder: (context, snapshot){
                          if(snapshot.data.toString().contains('00:00')&&
                            !_turnPage
                          ){
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) =>
                                Navigator.pop(context));
                          }
                          return RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: StringFinal()
                                          .verificationPageResendCode,
                                    ),
                                    TextSpan(
                                      text: snapshot.data.toString(),
                                    )
                                  ]
                              ),
                            );
                        },
                      ),

                      StreamBuilder(
                        initialData: false,
                        stream: Provider
                            .of<VerificationViewModel>(context,listen: false)
                            .insertButton,
                        builder: (context, snapshot){
                          return IconButton(
                            padding: const EdgeInsets.only(
                                right: 20,
                                bottom: 20
                            ),
                            onPressed: snapshot.data ?()async{
                              verificationId = AuthService.verificationId;
                              final valid = await AuthService()
                                  .signUpWithOTP(
                                  _pinCode.text,
                                  verificationId,
                                  widget.phoneNumber
                              );
                              if(!valid){
                                 await showOverlay(context);
                              }else{
                                _turnPage=true;
                              }
                            }: null,
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
              ),
            ],
          ),
        ),
      ),
    );
  }


}

