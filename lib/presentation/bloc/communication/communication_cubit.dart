import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app_clone_clean_arch/common/enums/message_enum.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/data/datasource/firebase_remote_datasource_impl.dart';
import '../../../data/model/call.dart';
import '../../../data/model/message_reply.dart';
import '../../../domain/entities/my_chat_entity.dart';
import '../../../domain/entities/text_message_entity.dart';
import '../../../domain/usecases/add_to_my_chat_usecase.dart';
import '../../../domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import '../../../domain/usecases/get_text_messages_usecase.dart';
import '../../../domain/usecases/make_call.dart';
import '../../../domain/usecases/send_image_message_use_case.dart';
import '../../../domain/usecases/send_text_message_usecase.dart';

part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetOneToOneSingleUserChatChannelUseCase
      getOneToOneSingleUserChatChannelUseCase;
  final GetTextMessagesUseCase getTextMessagesUseCase;
  final AddToMyChatUseCase addToMyChatUseCase;
  final SendImageMessageUseCase sendImageMessageUseCase;
  final MakeCallUseCase makeCallUseCase;
  final FirebaseRemoteDataSourceImpl? firebaseRemoteDataSourceImpl;

  CommunicationCubit({
    this.firebaseRemoteDataSourceImpl,
    required this.makeCallUseCase,
    required this.sendImageMessageUseCase,
    required this.getTextMessagesUseCase,
    required this.addToMyChatUseCase,
    required this.getOneToOneSingleUserChatChannelUseCase,
    required this.sendTextMessageUseCase,
  }) : super(CommunicationInitial());

  Future<void> sendTextMessage({
    required String senderName,
    required String senderId,
    required String recipientId,
    required String recipientName,
    required String message,
    required String recipientPhoneNumber,
    required String senderPhoneNumber,
    required String profileUrl,
    required MessageEnum messageEnum,
    required bool isSeen,
    required MessageReply? messageReply,
  }) async {
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);

      var messageId = const Uuid().v1();

      await sendTextMessageUseCase.sendTextMessage(
        TextMessageEntity(
          recipientName: recipientName,
          recipientUID: recipientId,
          senderName: senderName,
          time: Timestamp.now(),
          sederUID: senderId,
          message: message,
          messageId: messageId,
          messageType: messageEnum,
          isSeen: isSeen,
          repliedMessage: messageReply == null ? '' : messageReply.message,
          repliedTo: messageReply == null
              ? ''
              : messageReply.isMe
                  ? senderName
                  : recipientName,
          repliedMessageType: messageReply == null
              ? MessageEnum.text
              : messageReply.messageEnum,
        ),
        channelId,
      );

      await addToMyChatUseCase.call(MyChatEntity(
        time: Timestamp.now(),
        senderName: senderName,
        senderUID: senderId,
        senderPhoneNumber: senderPhoneNumber,
        recipientName: recipientName,
        recipientUID: recipientId,
        recipientPhoneNumber: recipientPhoneNumber,
        recentTextMessage: message,
        profileURL: profileUrl,
        isRead: true,
        isArchived: false,
        channelId: channelId,
      ));
    } on SocketException catch (_) {
      emit(CommunicationFailure());
    } catch (_) {
      emit(CommunicationFailure());
    }
  }

  Future<void> sendImageMessage({
    required String senderName,
    required String senderId,
    required String recipientId,
    required String recipientName,
    required String message,
    required String recipientPhoneNumber,
    required String senderPhoneNumber,
    required String profileUrl,
    required MessageEnum messageEnum,
    required bool isSeen,
    required MessageReply? messageReply,
  }) async {
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);
      var messageId = const Uuid().v1();
      await sendTextMessageUseCase.sendTextMessage(
        TextMessageEntity(
          recipientName: recipientName,
          recipientUID: recipientId,
          senderName: senderName,
          time: Timestamp.now(),
          sederUID: senderId,
          message: message,
          messageId: messageId,
          messageType: messageEnum,
          isSeen: isSeen,
          repliedMessage: messageReply == null ? '' : messageReply.message,
          repliedTo: messageReply == null
              ? ''
              : messageReply.isMe
                  ? senderName
                  : recipientName,
          repliedMessageType: messageReply == null
              ? MessageEnum.text
              : messageReply.messageEnum,
        ),
        channelId,
      );

      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = AppConst.photo;
          break;
        case MessageEnum.video:
          contactMsg = AppConst.video;
          break;
        case MessageEnum.audio:
          contactMsg = AppConst.audio;
          break;
        case MessageEnum.gif:
          contactMsg = AppConst.gif;
          break;
        default:
          contactMsg = AppConst.gif;
      }

      await addToMyChatUseCase.call(MyChatEntity(
        time: Timestamp.now(),
        senderName: senderName,
        senderUID: senderId,
        senderPhoneNumber: senderPhoneNumber,
        recipientName: recipientName,
        recipientUID: recipientId,
        recipientPhoneNumber: recipientPhoneNumber,
        recentTextMessage: contactMsg,
        profileURL: profileUrl,
        isRead: true,
        isArchived: false,
        channelId: channelId,
      ));
    } on SocketException catch (_) {
      emit(CommunicationFailure());
    } catch (_) {
      emit(CommunicationFailure());
    }
  }

  Future<void> getMessages(
      {required String senderId, required String recipientId}) async {
    emit(CommunicationLoading());
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);

      final messagesStreamData = getTextMessagesUseCase.call(channelId);
      messagesStreamData.listen((messages) {
        emit(CommunicationLoaded(messages: messages));
      });
    } on SocketException catch (_) {
      emit(CommunicationFailure());
    } catch (_) {
      emit(CommunicationFailure());
    }
  }

  Stream<DocumentSnapshot> get callStream =>
      firebaseRemoteDataSourceImpl!.callStream;

  void makeCall(
      {required String receiverName,
      required String receiverUid,
      required String receiverProfilePic,
      required String callerId,
      required String callerName,
      required String callerPic}) {
    String callId = const Uuid().v1();
    Call senderCallData = Call(
      callerId: callerId,
      callerName: callerName,
      callerPic: callerPic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: true,
    );

    Call recieverCallData = Call(
      callerId: callerId,
      callerName: callerName,
      callerPic: callerPic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: false,
    );
    makeCallUseCase.makeCall(senderCallData, recieverCallData);
  }
}
