import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class SendImageMessageUseCase{
  final FirebaseRepository repository;

  SendImageMessageUseCase({required this.repository});

  Future<void> sendImageMessage(TextMessageEntity textMessageEntity,String channelId)async{
    return await repository.sendImageMessage(textMessageEntity,channelId);
  }

}