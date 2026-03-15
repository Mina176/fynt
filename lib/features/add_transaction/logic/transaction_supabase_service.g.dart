// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_supabase_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transactionSupabaseService)
final transactionSupabaseServiceProvider =
    TransactionSupabaseServiceProvider._();

final class TransactionSupabaseServiceProvider
    extends
        $FunctionalProvider<
          TransactionSupabaseService,
          TransactionSupabaseService,
          TransactionSupabaseService
        >
    with $Provider<TransactionSupabaseService> {
  TransactionSupabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionSupabaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionSupabaseServiceHash();

  @$internal
  @override
  $ProviderElement<TransactionSupabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionSupabaseService create(Ref ref) {
    return transactionSupabaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionSupabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionSupabaseService>(value),
    );
  }
}

String _$transactionSupabaseServiceHash() =>
    r'efa6cac28d50d7adb2505c556fc4971aee61049f';
