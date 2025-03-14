import 'dart:async';

final class ErrorAbsorberTransformer<T> extends StreamTransformerBase<T, T> {
 
  const ErrorAbsorberTransformer();

  @override
  Stream<T> bind(Stream<T> stream) {
     final controller = StreamController<T>.broadcast();
    final sub = stream.handleError((_) => controller.close()).listen(
          controller.sink.add,
        );
    controller.onCancel = () {
      sub.cancel();
    };
    return controller.stream;
  }
}

extension AbsorbErrors<T> on Stream<T> {
  /// ```dart
  /// Stream<String> getNames() async* {
  ///   yield 'Vandad';
  ///   await Future.delayed(const Duration(seconds: 1));
  ///   yield 'John';
  ///   await Future.delayed(const Duration(seconds: 1));
  ///   throw 'Enough names for you';
  /// }
  ///
  /// Future<void> testIt() async {
  ///   await for (final name in getNames().absorbErrors()) {
  ///     name.log(); // Vandad, John, then stream closes
  ///   }
  /// }
  /// ```
  Stream<T> absorbErrors() => transform(ErrorAbsorberTransformer());
}
