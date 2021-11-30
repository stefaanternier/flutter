

class ApiResultError {
  int error;
  String message;

  ApiResultError({required this.error, required this.message}) {
    print("error ${this.error} - ${this.message}");
  }
}
