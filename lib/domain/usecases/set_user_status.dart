
import '../repositories/firebase_repository.dart';

class SetUserStatusUseCase{
  final FirebaseRepository repository;

  SetUserStatusUseCase({required this.repository});

  Future<void> call(bool isOnline)async{
    return await repository.setUserState(isOnline);
  }

}