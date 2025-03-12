import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FilePickers {
  // Private constructor
  FilePickers._internal();

  // Singleton instance
  static final FilePickers _instance = FilePickers._internal();

  // Factory constructor to return the same instance
  factory FilePickers() => _instance;

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        return imageFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File imageFile = File(photo.path);
      print(imageFile);
      // Do something with the image file
    }
  }
}
