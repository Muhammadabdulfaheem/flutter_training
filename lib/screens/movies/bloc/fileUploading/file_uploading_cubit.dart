import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/networking/api_services.dart';
import 'package:flutter_training_project/screens/movies/bloc/fileUploading/movie_file_uploading_state.dart';

class FileUploadingCubit extends Cubit<MovieFileUploadingState> {
  final ApiServices apiServices;

  FileUploadingCubit(this.apiServices) : super(FileUploadingInitial());

  Future<void> fileUploading(Uint8List bytes, String fileName) async {
    emit(FileLoading());
    try {
      final response = await apiServices.uploadFile(bytes, fileName);
      emit(FileUpoadingSuccess(fileUrl: response?.data['location']));
    } catch (e) {
      emit(FileUpoadingError(errorMesssge: e.toString()));
    }
  }
}
