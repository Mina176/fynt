// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrencyCode)
final currencyCodeProvider = CurrencyCodeProvider._();

final class CurrencyCodeProvider
    extends $NotifierProvider<CurrencyCode, String> {
  CurrencyCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyCodeHash();

  @$internal
  @override
  CurrencyCode create() => CurrencyCode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currencyCodeHash() => r'0f9ad6040a567e029e73555accfc473ff79ea2fb';

abstract class _$CurrencyCode extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrencySymbol)
final currencySymbolProvider = CurrencySymbolProvider._();

final class CurrencySymbolProvider
    extends $NotifierProvider<CurrencySymbol, String> {
  CurrencySymbolProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencySymbolProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencySymbolHash();

  @$internal
  @override
  CurrencySymbol create() => CurrencySymbol();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currencySymbolHash() => r'703a44c0bef6bb5f3d04daa3ebf0d33392963953';

abstract class _$CurrencySymbol extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
