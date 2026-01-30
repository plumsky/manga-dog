// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppConfigNotifier)
final appConfigProvider = AppConfigNotifierProvider._();

final class AppConfigNotifierProvider
    extends $NotifierProvider<AppConfigNotifier, AppConfig> {
  AppConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigNotifierHash();

  @$internal
  @override
  AppConfigNotifier create() => AppConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfig>(value),
    );
  }
}

String _$appConfigNotifierHash() => r'9c3045b927e0d65cd1c6a0295bb1c784710b50ae';

abstract class _$AppConfigNotifier extends $Notifier<AppConfig> {
  AppConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppConfig, AppConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppConfig, AppConfig>,
              AppConfig,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
