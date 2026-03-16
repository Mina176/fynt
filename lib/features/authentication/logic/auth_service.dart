import 'package:fintrack/features/authentication/data/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final auth = ref.watch(supabaseAuthProvider);
  return AuthService(auth);
}

@Riverpod(keepAlive: true)
supabase.GoTrueClient supabaseAuth(Ref ref) {
  return supabase.Supabase.instance.client.auth;
}

@Riverpod(keepAlive: true)
Stream<UserModel?> authStateChange(Ref ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges();
}

class AuthService {
  AuthService(this._supabaseAuth);
  final supabase.GoTrueClient _supabaseAuth;

  UserModel? get currentUser => _convertUser(_supabaseAuth.currentUser);

  UserModel? _convertUser(supabase.User? user) =>
      user == null ? null : UserModel.fromUser(user);

  Stream<UserModel?> authStateChanges() {
    return _supabaseAuth.onAuthStateChange.map((event) {
      return _convertUser(event.session?.user);
    });
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _supabaseAuth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        },
      );
    } on supabase.AuthException {
      rethrow;
    } catch (e) {
      throw Exception('An error occurred during sign up.');
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
    } on supabase.AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An error occurred during sign in.');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabaseAuth.resetPasswordForEmail(
        email,
        redirectTo: 'fintrack://reset',
      );
    } on supabase.AuthException catch (e) {
      throw Exception('Failed to send reset email. Message: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    await _supabaseAuth.updateUser(
      supabase.UserAttributes(password: newPassword),
    );
  }

  Future<supabase.User?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '18177035239-fa2crfmvdiu4p5cv2ki9ud24ruvesvv3.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      if (googleAuth.idToken == null) {
        throw Exception('No Access Token or ID Token found.');
      }
      final authResponse = await _supabaseAuth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.idToken,
      );
      return authResponse.user;
    } catch (e) {
      if (e.toString().toLowerCase().contains('cancel')) {
        return null;
      }
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      print('Skipping Google Sign-Out: $e');
    }
    await _supabaseAuth.signOut();
  }
}
