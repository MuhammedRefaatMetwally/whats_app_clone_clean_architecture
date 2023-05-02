import 'dart:io';

import '../repositories/firebase_repository.dart';

class UploadImageToStorageUseCase{
  final FirebaseRepository repository;

  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File? file , childName)async{
    return await repository.uploadImageToStorage(file, childName);
  }
}