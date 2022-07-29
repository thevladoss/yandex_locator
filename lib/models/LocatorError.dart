
class LocatorError {
  final int code;
  final String message;

  LocatorError({required this.code, required this.message});

  factory LocatorError.fromJson(Map<String, dynamic> json) {
    return LocatorError(
      code: json['error']['code'],
      message: json['error']['message'],
    );
  }
}
