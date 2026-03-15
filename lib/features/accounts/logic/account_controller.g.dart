// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountController)
final accountControllerProvider = AccountControllerProvider._();

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

String _$accountControllerHash() => r'57f054fb4f02fd0024e3ecab0851af3d035ca18c';

abstract class _$AccountController extends $AsyncNotifier<List<AccountModel>> {
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
