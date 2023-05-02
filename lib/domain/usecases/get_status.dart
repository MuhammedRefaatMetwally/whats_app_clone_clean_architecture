


import '../../data/model/status_model.dart';
import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class GetStatusUseCase{
  final FirebaseRepository repository;

  GetStatusUseCase({required this.repository});

  Future<List<Status>> call(){
    return repository.getStatus();
  }
}
