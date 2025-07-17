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

  Future<UserCredential?> signUpWithEmailAndPass(String email, String password, String name) async {
    try {
      UserCredential? userCredential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      return userCredential;
    } catch (error) {
      log("Creating user with email and pass error: ${error.toString()}");
      return null;
    }
  }

  Future<String?> changePassword(String currentPassword, String newPassword) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        return "Error: No user is currently signed in.";
      }

      String? email = currentUser.email;
      if (email == null) {
        return "Error: Couldn't retrieve user email.";
      }

      // Reauthenticate
      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await currentUser.reauthenticateWithCredential(credential);

      // Update password
      await currentUser.updatePassword(newPassword);
      await currentUser.reload(); // Optional: refresh user info

      return "Success: Password changed successfully.";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "Error: The current password is incorrect.";
      } else if (e.code == 'requires-recent-login') {
        return "Error: Please sign in again and try.";
      } else {
        return "Error: ${e.message}";
      }
    } catch (e) {
      return "Error: An unexpected error occurred.";
    }
  }

  String getDisplayName()  {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user?.displayName ?? '';
    } catch (e) {
      return '';
    }
  }

  String getUserEmail() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user?.email ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Success: Successfully sent reset email";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return("Error: Invalid Email Format");
      } else if (e.code == 'user-not-found') {
        return("Error: No user associated with this email.");
      } else {
        return("Error: An unknown error occured.");
      }
    }
    catch (error) {
      log("Error: Error while sending forgot password email.");
      return("Error: An unknown error occured.");
    }
  }

  Future<String?> signInWithEmailAndPass(String email, String password) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success: Logged in successfully";
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code} - ${e.message}");
      if (e.code == 'user-not-found') {
        return "Error: User not found for email";
      } else if (e.code == 'wrong-password') {
        return "Error: Email and password mismatch";
      } else if (e.code == 'invalid-credential') {
        return "Error: Invalid or expired credential";
      } else if (e.code == 'too-many-requests') {
        return "Error: Too many attempts, try again later.";
      } else if (e.code == 'user-disabled') {
        return "Error: This account has been disabled.";
      } else {
        return "Error: ${e.message ?? 'An unknown error occurred.'}";
      }
    }
    catch (error) {
      log("Logging user with email and pass error: ${error.toString()}");
      return "Error: An Error Occured.";
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "Success: Successfully Logged Out";
    } catch (error) {
      log("Google sign out error: ${error.toString()}");
      return("Error: An error occurred while logging out.");
    }
  }
}