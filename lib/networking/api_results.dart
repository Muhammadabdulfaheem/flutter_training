class APiStatus<T> {
  bool isLoading;
  String? error;
  T? data;

  APiStatus({this.isLoading = false, this.error, this.data});
}
