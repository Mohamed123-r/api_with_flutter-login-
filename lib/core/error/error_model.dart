import 'package:happy_tech_mastering_api_with_flutter/core/api/end_point.dart';

class ErrorModel {
  ErrorModel({
    required this.status,
    required this.errorMessage,
  });

  final num status;
  final String errorMessage;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json[ApiKeys.status],
        errorMessage: json[ApiKeys.errorMessage],
      );
}
