class ExternalError extends Error {
  final String message;

  ExternalError(this.message);

  @override
  String toString() {
    return "ExternalError: $message";
  }
}
