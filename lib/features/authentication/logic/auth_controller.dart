import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/features/authentication/logic/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthLoadingState build() {
    return const AuthLoadingState(LoadingStateEnum.initial, null);
  }

  Future<void> sigInInUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = const AuthLoadingState(LoadingStateEnum.loading, null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AuthLoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthLoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = const AuthLoadingState(LoadingStateEnum.loading, null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      state = const AuthLoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthLoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> signOut() async {
    state = const AuthLoadingState(LoadingStateEnum.loading, null);
    try {
      await ref.read(authServiceProvider).signOut();
      state = const AuthLoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthLoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AuthLoadingState(LoadingStateEnum.loading, null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.sendPasswordResetEmail(email);
      state = const AuthLoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthLoadingState(LoadingStateEnum.error, e);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoadingState(LoadingStateEnum.loading, null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithGoogle();
      state = const AuthLoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthLoadingState(LoadingStateEnum.error, e);
    }
  }
}
