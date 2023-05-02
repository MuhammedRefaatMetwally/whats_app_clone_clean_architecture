
import 'dart:io';
import 'package:whats_app_clone_clean_arch/data/model/group.dart'as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/call.dart';
import '../../data/model/status_model.dart';
import '../../data/model/user_model.dart';
import '../entities/my_chat_entity.dart';
import '../entities/text_message_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository{
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String?> getCurrentUID();
  Future<void> getCreateCurrentUser(UserEntity user);


  Stream<List<UserEntity>> getAllUsers();
  Stream<UserModel> getSingleUser(String userId);
  Stream<List<TextMessageEntity>> getMessages(String channelId);
  Stream<List<MyChatEntity>> getMyChat(String uid);

  Future<void> createOneToOneChatChannel(String uid,String otherUid);
  Future<String> getOneToOneSingleUserChannelId(String uid,String otherUid);
  Future<void> addToMyChat(MyChatEntity myChatEntity);
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity,String channelId);

  Future<String> uploadImageToStorage(File? file, String childName);

  Future<void> setUserState(bool isOnline);
  Future<void> setChatMessageSeen(String messageId, String channelId,);
  Future<void> uploadStatus({
    required String userName,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
  });
  Future<void> sendImageMessage(TextMessageEntity textMessageEntity,String channelId,);

  Future<List<Status>> getStatus();
  Future<void> createGroup({required String name, required File profilePic,
    required List<Contact> selectedContact});
  Stream<List<model.Group>> getChatGroups();
  void makeCall(Call senderCallData, Call receiverCallData,);

}