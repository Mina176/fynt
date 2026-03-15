// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_supabase_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accountSupabaseService)
final accountSupabaseServiceProvider = AccountSupabaseServiceProvider._();

final class AccountSupabaseServiceProvider
    extends
        $FunctionalProvider<
          AccountSupabaseService,
          AccountSupabaseService,
          AccountSupabaseService
        >
    with $Provider<AccountSupabaseService> {
  AccountSupabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountSupabaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountSupabaseServiceHash();

  @$internal
  @override
  $ProviderElement<AccountSupabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountSupabaseService create(Ref ref) {
    return accountSupabaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountSupabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountSupabaseService>(value),
    );
  }
}

String _$accountSupabaseServiceHash() =>
    r'6cf1bc71bd1447ffc280812554b2c9502923b8a3';
