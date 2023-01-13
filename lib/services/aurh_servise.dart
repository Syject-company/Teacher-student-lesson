import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _googleSignIn = GoogleSignIn(scopes: <String>['email']);
  final _facebookSignIn = FacebookAuth.instance;

  Future<String> signInWithFacebook() async {
    final LoginResult =
        await _facebookSignIn.login();
    return LoginResult.accessToken!.token;
  }

  Future<String> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return googleAuth.accessToken!;
  }

  Future<void> signOut() {
    return Future.wait([_googleSignIn.signOut(), _facebookSignIn.logOut()]);
  }
}
