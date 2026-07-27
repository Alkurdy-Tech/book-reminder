import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ---------- EMAIL/PASSWORD SIGNUP ----------
  Future<User?> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Send verification email
    await credential.user?.sendEmailVerification();

    return credential.user;
  }

  // ---------- EMAIL/PASSWORD LOGIN ----------
  Future<User?> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // ---------- GOOGLE SIGN-IN ----------
  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // user cancelled

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  // ---------- LOGOUT ----------
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // ---------- CURRENT USER ----------
  User? get currentUser => _auth.currentUser;
}