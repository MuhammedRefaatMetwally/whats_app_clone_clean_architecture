import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/user_model.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/get_single_user_usecase.dart';
part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  GetSingleUserCubit({required this.getSingleUserUseCase}) : super(GetSingleUserInitial());
  final GetSingleUserUseCase getSingleUserUseCase;

  Stream<UserModel> getSingleUsers({required String userId})  {
      return getSingleUserUseCase.call(userId);
  }
}
