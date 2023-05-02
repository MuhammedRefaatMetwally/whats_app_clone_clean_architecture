import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/my_chat_entity.dart';
import '../../../domain/usecases/get_my_chat_usecase.dart';
import '../../../domain/usecases/set_chat_message_seen_use_case.dart';
import '../../../domain/usecases/upload_image_to_storage_use_case.dart';

part 'my_chat_state.dart';

class MyChatCubit extends Cubit<MyChatState> {
  final GetMyChatUseCase getMyChatUseCase;
  final UploadImageToStorageUseCase uploadImageToStorageUseCase;
  final SetChatMessageSeen setChatMessageSeen;
  MyChatCubit({required this.uploadImageToStorageUseCase, required this.getMyChatUseCase,required this.setChatMessageSeen, }) : super(MyChatInitial());

  Future<void> getMyChat({required String uid,}) async {
    try {
      final myChatStreamData = getMyChatUseCase.call(uid);
      myChatStreamData.listen((myChatData) {
        emit(MyChatLoaded(myChat: myChatData));
      });
    } on SocketException catch (_) {} catch (_) {}
  }
  Future<String> uploadImageToStorage(File? file,String childName) async{
    return await uploadImageToStorageUseCase.call(file, childName);
  }
  void setMessageSeen(String messageId,String channelId)async{
    return await setChatMessageSeen.call(messageId, channelId);
  }
}

 /* Stream<List<MyChatEntity>> getChat({required String uid})  {
   Stream<List<MyChatEntity>> myChatStreamData;
   return  myChatStreamData = getMyChatUseCase.call(uid);
  }*/


