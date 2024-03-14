import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urban_culture/view/app_screens.dart';
import 'package:urban_culture/view/home/home_page.dart';

import '../services/firestore_service.dart';
import '../view/login/login_page.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var email;

  @override
  void onInit() {
    checkCurrentUser();
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential=GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken,idToken: googleSignInAuthentication.idToken);
        auth.signInWithCredential(credential);
        final UserCredential authResult =
        await auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if(user !=null){
          print("email: ${user.email!} name: ${user.displayName!}");
          FirestoreService().addUserToFirestore(user.email!,user.displayName!);

        }

        // Once user is signed in, we redirect to home screen
        Get.offAll(AppScreens());
      } else {
        print('Sign in process canceled by user.');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
  Future<void> signOut() async {
    try {
      await auth.signOut();
      // Once user is signed out, navigate to the login screen or any other desired screen
      Get.offAll(LoginPage()); // Assuming LoginPage is your login screen
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  void checkCurrentUser() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        email=user.email;
        // User is signed in, redirect to home screen
        Get.offAll(AppScreens());
      }
    });
  }
}
