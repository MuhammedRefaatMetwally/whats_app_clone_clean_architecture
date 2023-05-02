import 'dart:io';

import 'package:flutter_contacts/contact.dart';

import '../repositories/firebase_repository.dart';

class CreateGroupUseCase {
  final FirebaseRepository repository;

  CreateGroupUseCase({required this.repository});

  Future<void> call(
      {required String name,
      required File profilePic,
      required List<Contact> selectedContact}) async {
    return repository.createGroup(
        name: name, profilePic: profilePic, selectedContact: selectedContact);
  }
}
