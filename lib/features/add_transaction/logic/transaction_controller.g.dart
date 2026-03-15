// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionController)
@JsonPersist()
final transactionControllerProvider = TransactionControllerProvider._();

@JsonPersist()
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
    r'7991d41722a32edd480a210718138f1ee71fced8';

@JsonPersist()
abstract class _$TransactionControllerBase
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
    r'06901d8cd12e22264b871659be9a853653a8c224';

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
    r'bbd1f226d0740cd2b842e4b16969cf4d5248d6b6';

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
    r'a21a9361aab77e66763cac622632a9ea44bbfb82';

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
    r'bd70b761fa3fae5416e6ac180de5ef3f3529a734';

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
    r'8586bc13553a20ab465c5f8da19f545b7ac1f6b1';

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

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$TransactionController extends _$TransactionControllerBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "TransactionController";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<TransactionModel> state)? encode,
    List<TransactionModel> Function(String encoded)? decode,
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
                .map(
                  (e) => TransactionModel.fromJson(e as Map<String, Object?>),
                )
                .toList();
          },
      options: options,
    );
  }
}
