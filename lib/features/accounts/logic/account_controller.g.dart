// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountController)
@JsonPersist()
final accountControllerProvider = AccountControllerProvider._();

@JsonPersist()
final class AccountControllerProvider
    extends $AsyncNotifierProvider<AccountController, List<AccountModel>> {
  AccountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountControllerHash();

  @$internal
  @override
  AccountController create() => AccountController();
}

String _$accountControllerHash() => r'a4ae6a24fd9c618e34f6711460768abe5c35a885';

@JsonPersist()
abstract class _$AccountControllerBase
    extends $AsyncNotifier<List<AccountModel>> {
  FutureOr<List<AccountModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AccountModel>>, List<AccountModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AccountModel>>, List<AccountModel>>,
              AsyncValue<List<AccountModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(getNetWorth)
final getNetWorthProvider = GetNetWorthProvider._();

final class GetNetWorthProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  GetNetWorthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNetWorthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNetWorthHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return getNetWorth(ref);
  }
}

String _$getNetWorthHash() => r'59708e229c35a89cd6d29c4e71fdf313fa06b211';

@ProviderFor(netWorthStats)
final netWorthStatsProvider = NetWorthStatsProvider._();

final class NetWorthStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<NetWorthStats>,
          NetWorthStats,
          FutureOr<NetWorthStats>
        >
    with $FutureModifier<NetWorthStats>, $FutureProvider<NetWorthStats> {
  NetWorthStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'netWorthStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$netWorthStatsHash();

  @$internal
  @override
  $FutureProviderElement<NetWorthStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NetWorthStats> create(Ref ref) {
    return netWorthStats(ref);
  }
}

String _$netWorthStatsHash() => r'a8913cc7930f4d25e1f15ad36464d052ab3fcf82';

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$AccountController extends _$AccountControllerBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "AccountController";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<AccountModel> state)? encode,
    List<AccountModel> Function(String encoded)? decode,
    StorageOptions options = const StorageOptions(),
  }) {
    return NotifierPersistX(this).persist<String, String>(
      storage,
      key: key ?? this.key,
      encode: encode ?? $jsonCodex.encode,
      decode:
          decode ??
          (encoded) {
            final e = $jsonCodex.decode(encoded);
            return (e as List)
                .map((e) => AccountModel.fromJson(e as Map<String, Object?>))
                .toList();
          },
      options: options,
    );
  }
}
