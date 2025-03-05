// Flutter imports:

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/semantics.dart';

final class SystemEventObserver extends StatefulWidget {
  const SystemEventObserver({
    super.key,
    required this.child,
    this.lifeCycle,
    this.onSystemBrightnessChange,
    this.onSystemLocaleChange,
    this.onMemoryPressure,
    this.onAppExitRequest,
    this.onSystemAccessibilityFeaturesChanged,
  });
  final Widget child;
  final void Function(AppLifecycleState)? lifeCycle;
  final void Function(Brightness)? onSystemBrightnessChange;
  final void Function(List<Locale>?, Locale)? onSystemLocaleChange;
  final void Function()? onMemoryPressure;
  final Future<ui.AppExitResponse> Function()? onAppExitRequest;
  final void Function(AccessibilityFeatures)?
      onSystemAccessibilityFeaturesChanged;

  @override
  State<SystemEventObserver> createState() => _SystemEventObserverState();
}

final class _SystemEventObserverState extends State<SystemEventObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _checkSemantics();
  }

  void _checkSemantics() {
    if (ui.PlatformDispatcher.instance.semanticsEnabled) {
      SemanticsBinding.instance.ensureSemantics();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (widget.lifeCycle != null) {
      widget.lifeCycle!(state);
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    if (widget.onSystemBrightnessChange != null) {
      widget.onSystemBrightnessChange!(
          SchedulerBinding.instance.platformDispatcher.platformBrightness);
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (widget.onSystemLocaleChange != null &&
        locales != null &&
        locales.isNotEmpty) {
      final systemPreferedLocale = locales.first;
      // final systemPreferredLocale =
      //     SchedulerBinding.instance.platformDispatcher.locale;
      widget.onSystemLocaleChange!(
        locales,
        systemPreferedLocale,
      );
    }
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    if (widget.onMemoryPressure != null) {
      widget.onMemoryPressure!();
    }
  }

  @override
  Future<ui.AppExitResponse> didRequestAppExit() async {
    if (widget.onAppExitRequest != null) {
      return await widget.onAppExitRequest!();
    }
    return super.didRequestAppExit();
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    if (widget.onSystemAccessibilityFeaturesChanged != null) {
      final accessibilityFeatures =
          ui.PlatformDispatcher.instance.accessibilityFeatures;
      widget.onSystemAccessibilityFeaturesChanged!(accessibilityFeatures);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
