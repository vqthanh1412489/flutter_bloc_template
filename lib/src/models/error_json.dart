import 'dart:convert';

class ErrorJson {
  ErrorJson({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  factory ErrorJson.fromRawJson(String str) =>
      ErrorJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorJson.fromJson(Map<String, dynamic> json) => ErrorJson(
        message: json["message"] ?? json["status_message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
      };
}
