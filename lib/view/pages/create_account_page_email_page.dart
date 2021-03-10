import 'package:acazia_training/res/colors.dart';
import 'package:acazia_training/ultis/string_final.dart';
import 'package:acazia_training/ultis/text_form_field.dart';
import 'package:acazia_training/ultis/text_style.dart';
import 'package:acazia_training/view_model/create_email_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreateAccountEmailPage extends StatelessWidget {
  const CreateAccountEmailPage(
      {Key key, this.phoneNumber}
      ) : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Provider<CreateEmailViewModel>(
      create: (_) => CreateEmailViewModel(),
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState(){
    _nameController.addListener((){
      Provider.of<CreateEmailViewModel>(context, listen: false)
          .nameSink.add(_nameController.text);
    });

    _emailController.addListener((){
      Provider.of<CreateEmailViewModel>(context, listen: false)
          .emailSink.add(_emailController.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
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
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    StringFinal().createAccountNamePage,
                    style: TextStyleFinal.pageTitle,
                  ),
                  CustomTextFieldForm(_nameController, 'Name', false),
                  CustomTextFieldForm(_emailController, 'Email', true),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 170, 30, 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white),
                          children:[
                            TextSpan(
                                text: StringFinal()
                                    .createEmailAccountPolicyText1,
                            ),
                            TextSpan(
                              text: StringFinal().createEmailAccountTerm,
                              style: TextStyleFinal.underlineText,
                            ),
                            TextSpan(
                                text: StringFinal()
                                    .createEmailAccountPolicyText2,
                            ),
                            TextSpan(
                                text: StringFinal().createEmailAccountPolicy,
                              style: TextStyleFinal.underlineText,
                            )
                          ]
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: StreamBuilder<bool>(
                      initialData: false,
                      stream: Provider.of<CreateEmailViewModel>(context)
                          .insertButton,
                      builder: (context, snapshot) {
                        return IconButton(
                          padding: const EdgeInsets.only(right: 20, bottom: 20),
                          onPressed: snapshot.data ?()async{
                            final FirebaseUser user = await FirebaseAuth
                                .instance.currentUser();
                              Provider.of<CreateEmailViewModel>(context,
                                  listen: false)
                                  .submit(
                                  formKey,
                                  _nameController,
                                  _emailController,
                                  user,
                                  context);
                          }:null,
                          icon: FaIcon(FontAwesomeIcons.arrowCircleRight),
                          iconSize: 50,
                          disabledColor: Colors.grey,
                          color: Colors.white,
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

