class InternalError extends Error {
  final String message;

  InternalError(this.message);

  @override
  String toString() {
    return "InternalError: $message";
  }
}
