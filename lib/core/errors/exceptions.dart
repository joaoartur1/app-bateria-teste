class NativeException implements Exception {
  final String message;
  NativeException(this.message);

  @override
  String toString() => message;
}
