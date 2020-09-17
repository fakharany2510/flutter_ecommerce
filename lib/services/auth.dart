import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signIn(String email, String pass) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return authResult;
  }

  Future<AuthResult> logIn(String email, String pass) async {
    final authResult =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return authResult;
  }
}
