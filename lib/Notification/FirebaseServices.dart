// import 'dart:ffi';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class FirebaseServices
// {
//   final _auth = FirebaseAuth.instance;
//   final _googleSignIn = GoogleSignIn();
//   late UserCredential userCredential;
//
//   Future<UserCredential> signInWithGooglewithFirebase()
//   async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       if (googleSignInAccount != null)
//       {
//
//         final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//         final AuthCredential authCredential =
//         GoogleAuthProvider.credential(
//             accessToken: googleSignInAuthentication.accessToken,
//             idToken: googleSignInAuthentication.idToken);
//            userCredential =  await _auth.signInWithCredential(authCredential);
//
//          }
//           } on FirebaseAuthException catch (e)
//        {
//       print(e.message);
//       throw e;
//     }
//     return userCredential;
//   }
//
//
//    signInWithFacebook() async
//   {
//
//     try
//     {
//        print("djfkg");
//       final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile', 'user_birthday']
//     );
//
//     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
//     final userData = await FacebookAuth.instance.getUserData();
//
//     String userEmail = userData['email'];
//     print("djfkghjkdfg"+userEmail+"fdfgdgf"+FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).toString());
//
//        print("djfkg");
//      } on
//     FirebaseAuthException catch (e)
//     {
//       print("djfkg");
//       print("sdfdf"+e.message.toString());
//       throw e;
//     }
//     }
//
//   googleSignOut() async
//   {
//
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//   }
// }


import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vlesociety/Auth/controller/login_controller.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LoginController _controller = Get.put(LoginController());
  Future<UserCredential?> signInWithGooglewithFirebase() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(authCredential);
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signInWithFacebook(String deviceId) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile', 'user_birthday']);
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final userData = await FacebookAuth.instance.getUserData();
      String userEmail = userData['email'];
      print("Email: $userEmail");

      UserCredential userCredential = await _auth.signInWithCredential(facebookAuthCredential);
      _controller.signUpwithSocialLoginNetworkApi(userCredential, deviceId);
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      throw e;
    }
  }

  Future<void> googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}