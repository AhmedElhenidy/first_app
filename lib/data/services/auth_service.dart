import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  static Future<UserCredential?> signIn(String mail,String password,)async{
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }else{
        print(e.message);
      }
    }
    return null;
  }

  static Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }catch(e){
      return null;
    }
  }
}