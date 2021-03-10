import 'package:acazia_training/models/user.dart';
import 'package:acazia_training/navigation/navigation.dart';
import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/ultis/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService{

  static String verificationId;

  User getUserInformation(FirebaseUser user) {
    return user != null ? User(id: user.uid) :null;
  }
  
  Stream<User> get user {
    return FirebaseAuth.instance.onAuthStateChanged.map(getUserInformation)
        .handleError((onError){
      debugPrint(onError.toString());
    });
  }

  Future linkUser(String token) async {
    final AuthCredential credential = FacebookAuthProvider
        .getCredential(accessToken: token);
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((AuthResult user) {
          if(user != null) {
            createEmail(user.user, null);
          }
    });
  }

  Future createEmail(FirebaseUser user, String email)async{
    try{
      if(email != null){
        final AuthCredential CredentialEmail = EmailAuthProvider
            .getCredential(email: email, password: '123456');
        await user.linkWithCredential(CredentialEmail).then((onValue){
          debugPrint('here');
          if(onValue != null){
            Navigation.instance.navigateTo(COMPLETE_PAGE, arguments: null);
          }
        });
      }
      else{
        final AuthCredential credentialEmail = EmailAuthProvider
            .getCredential(email: user.email, password: '123456');
        await user.linkWithCredential(credentialEmail).then((onValue){
          if(onValue != null){
            Navigation.instance.navigateTo(COMPLETE_PAGE, arguments: null);
          }
        });

      }
    }catch(e){
      debugPrint(e);
    }

  }

  Future submitPhoneNumber(String phone, int second) async{
    final PhoneVerificationCompleted verificationCompleted =
        _signInByPhone;

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      Navigation.instance.navigateAndRemove(SIGN_UP,arguments: null);
      debugPrint('ERROR ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String getVerificationId, [int forceResendingToken]){
      verificationId = getVerificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String getVerificationId) {
      verificationId = getVerificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: second),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  Future<void> signInByEmail(String email, BuildContext context)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: '123456').then((AuthResult result){
       if(result != null){
         Navigation.instance.navigateAndRemove(COMPLETE_PAGE, arguments: null);
       }
    }).catchError((onError){
      ErrorDialog.showErrorDialog(onError.toString(), context);
    });
  }

  void _signInByPhone(AuthCredential authCredential){
    FirebaseAuth.instance.signInWithCredential(authCredential)
        .then((AuthResult result){
      if(result != null) {
        Navigation.instance.navigateAndRemove
          (COMPLETE_PAGE, arguments: null);
      }
    }).catchError((onError){
        debugPrint(onError.toString());
    });
  }

  Future<bool> signUpWithOTP(
      String smsCode,
      String verificationID,
      String phone) async{
    final AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationID, smsCode: smsCode);
    bool isSignIn = false;
    await FirebaseAuth.instance.signInWithCredential(authCredential)
        .then((AuthResult result){
      if(result!=null){
        Navigation.instance.navigateTo
          (CREATE_ACCOUNT_EMAIL,arguments: phone);
        isSignIn = true;
      }
      else{
        isSignIn = false;
      }
    }).catchError((onError){
      if(onError.toString().contains('ERROR_INVALID_VERIFICATION_CODE')){
        isSignIn = false;
      }
    });
    return isSignIn;
  }
}