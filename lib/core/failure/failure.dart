// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure {
  final String error;
  final String? statusCode;
  Failure({required this.error, this.statusCode});

  @override
  String toString() => 'Failure(error: $error, statusCode: $statusCode)';
}
