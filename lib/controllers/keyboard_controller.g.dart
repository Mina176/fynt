// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KeypadController)
final keypadControllerProvider = KeypadControllerProvider._();

final class KeypadControllerProvider
    extends $NotifierProvider<KeypadController, bool> {
  KeypadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keypadControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$keypadControllerHash();

  @$internal
  @override
  KeypadController create() => KeypadController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$keypadControllerHash() => r'b42402509d05054810daef72199e64b12e9ace5d';

abstract class _$KeypadController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
