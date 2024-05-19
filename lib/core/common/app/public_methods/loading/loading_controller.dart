import 'package:flutter/material.dart';

class LoadingIndicatorController {
  LoadingIndicatorController._internal();

  static final LoadingIndicatorController _instance =
      LoadingIndicatorController._internal();

  static LoadingIndicatorController get instance => _instance;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void show() {
    _isLoading.value = true;
  }

  void hide() {
    _isLoading.value = false;
  }

  ValueNotifier<bool> get isLoading => _isLoading;
}
