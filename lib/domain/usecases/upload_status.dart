
import 'dart:io';

import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class UploadStatusUseCase{
  final FirebaseRepository repository;

  UploadStatusUseCase({required this.repository});

  Future<void> call({
    required String userName,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
  })async{
    return await repository.uploadStatus(userName: userName, profilePic: profilePic, phoneNumber: phoneNumber, statusImage: statusImage);
  }

}