import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithEmail({
    required String email,
    required String password,
    required Function(FirebaseAuthException e) errorCallback,
  }) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e){
      errorCallback(e);
    }
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required Function(FirebaseAuthException e) errorCallback,
  }) async{
    try{
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if(user.user != null){
        return user.user;
      } else{
        return null;
      }
    } on FirebaseAuthException catch (e){
      errorCallback(e);
    }
    return null;
  }

  void signOut(){
    _firebaseAuth.signOut();
  }

}