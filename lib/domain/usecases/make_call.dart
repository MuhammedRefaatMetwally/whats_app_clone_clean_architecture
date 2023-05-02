import '../../data/model/call.dart';
import '../entities/my_chat_entity.dart';
import '../repositories/firebase_repository.dart';

class MakeCallUseCase{
  final FirebaseRepository repository;

  MakeCallUseCase({required this.repository});

 void makeCall(Call senderCallData, Call receiverCallData,)async{
    return  repository.makeCall(senderCallData, receiverCallData);
  }
}