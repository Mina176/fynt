// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionController)
final transactionControllerProvider = TransactionControllerProvider._();

final class TransactionControllerProvider
    extends
        $AsyncNotifierProvider<TransactionController, List<TransactionModel>> {
  TransactionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionControllerHash();

  @$internal
  @override
  TransactionController create() => TransactionController();
}

String _$transactionControllerHash() =>
    r'e4a8769010173bf475aff2169396139ca57e12e6';

abstract class _$TransactionController
    extends $AsyncNotifier<List<TransactionModel>> {
  FutureOr<List<TransactionModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TransactionModel>>, List<TransactionModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionModel>>,
                List<TransactionModel>
              >,
              AsyncValue<List<TransactionModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(recentTransactions)
final recentTransactionsProvider = RecentTransactionsProvider._();

final class RecentTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransactionModel>>,
          List<TransactionModel>,
          FutureOr<List<TransactionModel>>
        >
    with
        $FutureModifier<List<TransactionModel>>,
        $FutureProvider<List<TransactionModel>> {
  RecentTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentTransactionsHash();

  @$internal
  @override
  $FutureProviderElement<List<TransactionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TransactionModel>> create(Ref ref) {
    return recentTransactions(ref);
  }
}

String _$recentTransactionsHash() =>
    r'5abcdf892a004e4a57ef39a79df6591743c77f7e';

@ProviderFor(getWeeklySpendings)
final getWeeklySpendingsProvider = GetWeeklySpendingsProvider._();

final class GetWeeklySpendingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<double>>,
          List<double>,
          FutureOr<List<double>>
        >
    with $FutureModifier<List<double>>, $FutureProvider<List<double>> {
  GetWeeklySpendingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeeklySpendingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeeklySpendingsHash();

  @$internal
  @override
  $FutureProviderElement<List<double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<double>> create(Ref ref) {
    return getWeeklySpendings(ref);
  }
}

String _$getWeeklySpendingsHash() =>
    r'44cc938e2bf764149ba7eef6f362409f23fbd71d';

@ProviderFor(getPreviousWeekTotal)
final getPreviousWeekTotalProvider = GetPreviousWeekTotalProvider._();

final class GetPreviousWeekTotalProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  GetPreviousWeekTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPreviousWeekTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPreviousWeekTotalHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return getPreviousWeekTotal(ref);
  }
}

String _$getPreviousWeekTotalHash() =>
    r'31893fcbc8b2c8acf705d7e864f2457cb0871021';

@ProviderFor(getPreviousMonthTotal)
final getPreviousMonthTotalProvider = GetPreviousMonthTotalProvider._();

final class GetPreviousMonthTotalProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  GetPreviousMonthTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPreviousMonthTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPreviousMonthTotalHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return getPreviousMonthTotal(ref);
  }
}

String _$getPreviousMonthTotalHash() =>
    r'a85493ebc42ae4e44426e5f64a4e7e965d278441';

@ProviderFor(isFirstMonthOfActivity)
final isFirstMonthOfActivityProvider = IsFirstMonthOfActivityProvider._();

final class IsFirstMonthOfActivityProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  IsFirstMonthOfActivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFirstMonthOfActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFirstMonthOfActivityHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isFirstMonthOfActivity(ref);
  }
}

String _$isFirstMonthOfActivityHash() =>
    r'bc725dfac7e981b1db26373858c28cfc4753aaa3';

@ProviderFor(isFirstWeekOfActivity)
final isFirstWeekOfActivityProvider = IsFirstWeekOfActivityProvider._();

final class IsFirstWeekOfActivityProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  IsFirstWeekOfActivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFirstWeekOfActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFirstWeekOfActivityHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isFirstWeekOfActivity(ref);
  }
}

String _$isFirstWeekOfActivityHash() =>
    r'6e00fb03ab42b1c2463e5452623001cc6c007718';

@ProviderFor(getWeeklyDashboardData)
final getWeeklyDashboardDataProvider = GetWeeklyDashboardDataProvider._();

final class GetWeeklyDashboardDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardData>,
          DashboardData,
          FutureOr<DashboardData>
        >
    with $FutureModifier<DashboardData>, $FutureProvider<DashboardData> {
  GetWeeklyDashboardDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeeklyDashboardDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeeklyDashboardDataHash();

  @$internal
  @override
  $FutureProviderElement<DashboardData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardData> create(Ref ref) {
    return getWeeklyDashboardData(ref);
  }
}

String _$getWeeklyDashboardDataHash() =>
    r'46d65a4a6ff5e609ccfda03562ccf40cdaaeca9d';
