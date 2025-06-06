import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser()async{
    return await auth.currentUser;
  }

  Future SignOut()async{
    await FirebaseAuth.instance.signOut();
  }

   Future<void> deleteUserWithPassword(String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.delete();
      } on FirebaseAuthException catch (e) {
        throw e; // Re-throw so we can handle it in the UI
      }
    }
  }
}