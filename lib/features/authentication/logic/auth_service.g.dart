// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authService)
final authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'85c1a5d9e782312a2c80f619fdc7ee5134870237';

@ProviderFor(supabaseAuth)
final supabaseAuthProvider = SupabaseAuthProvider._();

final class SupabaseAuthProvider
    extends
        $FunctionalProvider<
          supabase.GoTrueClient,
          supabase.GoTrueClient,
          supabase.GoTrueClient
        >
    with $Provider<supabase.GoTrueClient> {
  SupabaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseAuthHash();

  @$internal
  @override
  $ProviderElement<supabase.GoTrueClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  supabase.GoTrueClient create(Ref ref) {
    return supabaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(supabase.GoTrueClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<supabase.GoTrueClient>(value),
    );
  }
}

String _$supabaseAuthHash() => r'1d92dffa2601f21feaf4a3757a7479303800612c';

@ProviderFor(authStateChange)
final authStateChangeProvider = AuthStateChangeProvider._();

final class AuthStateChangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserModel?>,
          UserModel?,
          Stream<UserModel?>
        >
    with $FutureModifier<UserModel?>, $StreamProvider<UserModel?> {
  AuthStateChangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateChangeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateChangeHash();

  @$internal
  @override
  $StreamProviderElement<UserModel?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<UserModel?> create(Ref ref) {
    return authStateChange(ref);
  }
}

String _$authStateChangeHash() => r'39f6c89ec0680d3700900e67dd75ab8135fd41cb';
