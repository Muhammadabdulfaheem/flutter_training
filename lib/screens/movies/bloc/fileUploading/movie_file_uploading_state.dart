abstract class MovieFileUploadingState {}

class FileUploadingInitial extends MovieFileUploadingState {}

class FileLoading extends MovieFileUploadingState {}

class FileUpoadingSuccess extends MovieFileUploadingState {
  final String fileUrl;

  FileUpoadingSuccess({required this.fileUrl});
}

class FileUpoadingError extends MovieFileUploadingState {
  final String errorMesssge;

  FileUpoadingError({required this.errorMesssge});
}
