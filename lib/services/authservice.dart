import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iotlights/confirmation_page.dart';

class AuthService{
  Future<void> signUp(email,username,password,context) async{

    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        // additional attributes as needed
      };
      Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes)
      ).then((value) => {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConfirmationPage(
          username: username
            )
            )
        )
      });

    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }
  Future<void> confirmUser(username,confirmationCode,context) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
          username: username,
          confirmationCode: confirmationCode
      );
      if(res.isSignUpComplete){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }



  Future<void> signIn( username,  password, userSignedIn) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
       userSignedIn.setUserCurrentState(res.isSignedIn);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> signOut(context , userSignedIn) async {
    try {
      final res = await Amplify.Auth.signOut();
      userSignedIn.setUserCurrentState(false);
    } on AuthException catch (e) {
      print(e.message);
    }
  }

}