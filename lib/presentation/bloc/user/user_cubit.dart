import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/create_one_to_one_chat_channel_usecase.dart';
import '../../../domain/usecases/get_all_user_usecase.dart';
import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../../../domain/usecases/get_single_user_usecase.dart';
import '../../../domain/usecases/set_user_status.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUserUseCase getAllUserUseCase;
  final CreateOneToOneChatChannelUseCase createOneToOneChatChannelUseCase;
  final SetUserStatusUseCase setUserStatusUseCase;
  UserCubit( {
    required this.getAllUserUseCase,
    required this.createOneToOneChatChannelUseCase,
    required this.setUserStatusUseCase,
  }) : super(UserInitial());
 static UserCubit i(BuildContext context)=>BlocProvider.of(context);
  Future<void> getAllUsers()async{
   try{
     final userStreamData=getAllUserUseCase.call();
     userStreamData.listen((users) {
       emit(UserLoaded(users));
     });
   }on SocketException catch(_){
     emit(UserFailure());
   }catch(e){
     print("ERROR ${e.toString()}");
     emit(UserFailure());
   }
  }
  Future<void> createChatChannel({required String uid,required  String otherUid})async{
    try{
      await createOneToOneChatChannelUseCase.call(uid, otherUid);
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_){
      emit(UserFailure());
    }
  }
  Stream<List<UserEntity>> getUsers(){
    Stream<List<UserEntity>> userStreamData;
    return userStreamData=getAllUserUseCase.call();

  }

  void setUserStatus(bool isOnline){
    setUserStatusUseCase.call(isOnline);
  }


}
