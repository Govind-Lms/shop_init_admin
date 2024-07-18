import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_init_admin/src/consts/constant.dart';

class AuthRepo{



  Future<dynamic> signInWithGoogle() async {
    try { 
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      
      return await FirebaseAuth.instance.signInWithCredential(credential);
      
    } on Exception catch (e) {
      print('Exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

}