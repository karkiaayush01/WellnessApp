import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //Obtain the auth details for the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      //Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log("Google authentication error: $error");
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPass(String email, String password) async {
      try {
        return await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
      } catch (error) {
        log("Creating user with email and pass error: ${error.toString()}");
        return null;
      }
  }

  Future<UserCredential?> signInWithEmailAndPass(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        log("Sign in error: User not found for email");
      }
      else if(e.code == 'wrong-password'){
        log("Sign in error: Email and password mismatch");
      }
      return null;
    }
    catch (error) {
      log("Logging user with email and pass error: ${error.toString()}");
      return null;
    }
  }

  Future<void> googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      log("Google sign out error: ${error.toString()}");
    }
  }
}