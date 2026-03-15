// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BudgetController)
final budgetControllerProvider = BudgetControllerProvider._();

final class BudgetControllerProvider
    extends $AsyncNotifierProvider<BudgetController, void> {
  BudgetControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetControllerHash();

  @$internal
  @override
  BudgetController create() => BudgetController();
}

String _$budgetControllerHash() => r'abab231005efa3754c888c48869667c86f4656d5';

abstract class _$BudgetController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(getBudgets)
final getBudgetsProvider = GetBudgetsFamily._();

final class GetBudgetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BudgetModel>>,
          List<BudgetModel>,
          FutureOr<List<BudgetModel>>
        >
    with
        $FutureModifier<List<BudgetModel>>,
        $FutureProvider<List<BudgetModel>> {
  GetBudgetsProvider._({
    required GetBudgetsFamily super.from,
    required RecurrenceDuration super.argument,
  }) : super(
         retry: null,
         name: r'getBudgetsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getBudgetsHash();

  @override
  String toString() {
    return r'getBudgetsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BudgetModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BudgetModel>> create(Ref ref) {
    final argument = this.argument as RecurrenceDuration;
    return getBudgets(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBudgetsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getBudgetsHash() => r'3bb9880445976e3801e6c2732e5819fa6fe9a574';

final class GetBudgetsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<BudgetModel>>,
          RecurrenceDuration
        > {
  GetBudgetsFamily._()
    : super(
        retry: null,
        name: r'getBudgetsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetBudgetsProvider call(RecurrenceDuration period) =>
      GetBudgetsProvider._(argument: period, from: this);

  @override
  String toString() => r'getBudgetsProvider';
}

@ProviderFor(getAllBudgetsDetails)
final getAllBudgetsDetailsProvider = GetAllBudgetsDetailsFamily._();

final class GetAllBudgetsDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AllBudgetsDetails>,
          AllBudgetsDetails,
          FutureOr<AllBudgetsDetails>
        >
    with
        $FutureModifier<AllBudgetsDetails>,
        $FutureProvider<AllBudgetsDetails> {
  GetAllBudgetsDetailsProvider._({
    required GetAllBudgetsDetailsFamily super.from,
    required RecurrenceDuration super.argument,
  }) : super(
         retry: null,
         name: r'getAllBudgetsDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getAllBudgetsDetailsHash();

  @override
  String toString() {
    return r'getAllBudgetsDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AllBudgetsDetails> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AllBudgetsDetails> create(Ref ref) {
    final argument = this.argument as RecurrenceDuration;
    return getAllBudgetsDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAllBudgetsDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getAllBudgetsDetailsHash() =>
    r'112c1850308b03ba826d00bcd0d279e285c2aa9d';

final class GetAllBudgetsDetailsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<AllBudgetsDetails>,
          RecurrenceDuration
        > {
  GetAllBudgetsDetailsFamily._()
    : super(
        retry: null,
        name: r'getAllBudgetsDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetAllBudgetsDetailsProvider call(RecurrenceDuration period) =>
      GetAllBudgetsDetailsProvider._(argument: period, from: this);

  @override
  String toString() => r'getAllBudgetsDetailsProvider';
}
