 //Pub
 //firebase_core: ^1.7.0
 //firebase_auth: ^3.1.1
 //google_sign_in: ^5.2.1
  

 
 
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;


Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print('Google sign-in failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (error) {
      print('Sign out failed: $error');
    }
  }
}
