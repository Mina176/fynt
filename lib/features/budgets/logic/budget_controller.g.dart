// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BudgetController)
final budgetControllerProvider = BudgetControllerFamily._();

final class BudgetControllerProvider
    extends $AsyncNotifierProvider<BudgetController, List<BudgetModel>> {
  BudgetControllerProvider._({
    required BudgetControllerFamily super.from,
    required RecurrenceDuration super.argument,
  }) : super(
         retry: null,
         name: r'budgetControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$budgetControllerHash();

  @override
  String toString() {
    return r'budgetControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BudgetController create() => BudgetController();

  @override
  bool operator ==(Object other) {
    return other is BudgetControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$budgetControllerHash() => r'72943c89c8067858d5b3a4dbcfccac17a665ad61';

final class BudgetControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BudgetController,
          AsyncValue<List<BudgetModel>>,
          List<BudgetModel>,
          FutureOr<List<BudgetModel>>,
          RecurrenceDuration
        > {
  BudgetControllerFamily._()
    : super(
        retry: null,
        name: r'budgetControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BudgetControllerProvider call(RecurrenceDuration period) =>
      BudgetControllerProvider._(argument: period, from: this);

  @override
  String toString() => r'budgetControllerProvider';
}

abstract class _$BudgetController extends $AsyncNotifier<List<BudgetModel>> {
  late final _$args = ref.$arg as RecurrenceDuration;
  RecurrenceDuration get period => _$args;

  FutureOr<List<BudgetModel>> build(RecurrenceDuration period);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BudgetModel>>, List<BudgetModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BudgetModel>>, List<BudgetModel>>,
              AsyncValue<List<BudgetModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
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
    r'bb4a436418a1923c71315a3e0316485249727821';

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
