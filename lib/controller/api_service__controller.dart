class ApiControler<T> {
  T data;
  int? statusCode;
  bool error;
  String? message;

  ApiControler(
      {required this.data, this.statusCode, this.error = false, this.message});
}
