import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart/root_screen.dart';
import 'package:shopsmart/services/my_app_function.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({required BuildContext context}) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      log('Hello1');
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        log('Hello2');
        log(googleAuth.accessToken.toString());
        log(googleAuth.idToken.toString());
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResults = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));
          log(authResults.credential!.token.toString());
          log('Hello3');

          if (authResults.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResults.user!.uid)
                .set({
              'userId': authResults.user!.uid,
              'userName': authResults.user!.displayName,
              'userImage': authResults.user!.photoURL,
              'userEmail': authResults.user!.email,
              'createdAt': Timestamp.now(), 
              'userWish': [],
              'userCart': [],
            });
          }
        }
      }
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Navigator.pushReplacementNamed(context, RootSceen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subTitle: e.message.toString(),
        fct: () {},
      );
    } catch (e) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subTitle: e.toString(),
        fct: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        await _googleSignIn(context: context);
      },
    );
  }
}
