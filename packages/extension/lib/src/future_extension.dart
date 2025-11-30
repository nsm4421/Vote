import 'dart:async';

extension FutureExtension<T> on Future<T> {
  Future<T?> ignoreError() async {
    try {
      return await this;
    } catch (_) {
      return null;
    }
  }

  Future<T?> withTimeoutOrNull(Duration duration) async {
    try {
      return await timeout(duration);
    } on TimeoutException {
      return null;
    }
  }

  Future<T> delay(Duration duration) async {
    await Future.delayed(duration);
    return await this;
  }
}
