
import '../../data/model/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetSingleUserUseCase{
  final FirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<UserModel> call(String userId){
    return repository.getSingleUser(userId);
  }

}