
import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetAllUserUseCase{
  final FirebaseRepository repository;

  GetAllUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(){
    return repository.getAllUsers();
  }

}