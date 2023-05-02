import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class SetChatMessageSeen{
  final FirebaseRepository repository;

  SetChatMessageSeen({required this.repository});

  Future<void> call(String messageId, String channelId)async{
    return await repository.setChatMessageSeen(messageId,channelId);
  }

}