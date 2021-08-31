class APIResponse<T> {
  APIResponse({this.data, this.error = false, this.errorMessage = ''});
  T? data;
  bool error;
  String errorMessage;
}
