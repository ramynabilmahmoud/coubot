import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:coubot/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// SignInWithGoogleStrategy
// ignore: one_member_abstracts
abstract class SignInWithGoogleStrategy {
  /// Generative constructor
  SignInWithGoogleStrategy();

  /// factory named constructor getStrategy
  factory SignInWithGoogleStrategy.getStrategy() {
    return SignInWithGoogleSharedStrategy();
  }

  /// Sign in with Google
  Future<AuthResponse> signInWithGoogle();
}

/// recognize a user
class SignInWithGoogleSharedStrategy extends SignInWithGoogleStrategy {
  /// Sign in with Google
  @override
  Future<AuthResponse> signInWithGoogle() async {
    final iosClientId = dotenv.env['IOS_CLIENT_ID'];

    final androidClientId = dotenv.env['ANDROID_CLIENT_ID'];

    final webClientId = dotenv.env['WEB_CLIENT_ID'];

    final googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS ? iosClientId : androidClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw const AuthException('No Access Token found.');
    }
    if (idToken == null) {
      throw const AuthException('No ID Token found.');
    }

    final result = await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    return result;
  }
}
