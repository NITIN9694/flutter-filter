// firebase_core: ^1.7.0
//firebase_auth: ^3.1.1

 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Sign in failed: $error');
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print('Registration failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      print('Sign out failed: $error');
    }
  }