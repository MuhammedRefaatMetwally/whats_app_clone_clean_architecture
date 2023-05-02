
import 'package:whats_app_clone_clean_arch/data/model/group.dart';
import '../entities/my_chat_entity.dart';
import '../repositories/firebase_repository.dart';

class GetChatGroupUseCase{
  final FirebaseRepository repository;

  GetChatGroupUseCase({required this.repository});

  Stream<List<Group>>  call(){
    return repository.getChatGroups();
  }
}