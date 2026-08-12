import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ---------- EMAIL/PASSWORD SIGNUP ----------
  Future<User?> signUp(String name, String email, String password) async {
  final credential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
    await credential.user?.updateDisplayName(name);
    await credential.user?.reload(); 
    // Send verification email
    await credential.user?.sendEmailVerification();
    print("Verification email sent to $email");
    print("Verification email sent to ${credential.user?.email}");
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
  try {
    await _auth.signOut();
  } catch (e) {
    print("Firebase sign out error: $e");
  }

  try {
    await _googleSignIn.signOut();
  } catch (e) {
    print("Google sign out error: $e");
  }
}
Future<void> sendPasswordReset(String email) async {
  await _auth.sendPasswordResetEmail(email: email);
}
  // ---------- CURRENT USER ----------
  User? get currentUser => _auth.currentUser;
}