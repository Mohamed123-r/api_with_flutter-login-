class ErrorModel {
  ErrorModel({
    required this.status,
    required this.errorMessage,
  });

  final num status;
  final String errorMessage;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        errorMessage: json["errorMessage"],
      );
}
