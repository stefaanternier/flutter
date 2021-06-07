

class ApiResultError {
  int error;
  String message;

  ApiResultError({this.error, this.message}) {
    print("error ${this.error} - ${this.message}");
  }
}
