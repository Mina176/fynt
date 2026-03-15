// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_supabase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetSupabaseService)
final budgetSupabaseServiceProvider = BudgetSupabaseServiceProvider._();

final class BudgetSupabaseServiceProvider
    extends
        $FunctionalProvider<
          BudgetSupabaseService,
          BudgetSupabaseService,
          BudgetSupabaseService
        >
    with $Provider<BudgetSupabaseService> {
  BudgetSupabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetSupabaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetSupabaseServiceHash();

  @$internal
  @override
  $ProviderElement<BudgetSupabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetSupabaseService create(Ref ref) {
    return budgetSupabaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetSupabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetSupabaseService>(value),
    );
  }
}

String _$budgetSupabaseServiceHash() =>
    r'2c9c876f990bd4b42094911ffa6806d9be67697b';
