import 'dart:io';
import 'package:whats_app_clone_clean_arch/data/model/call.dart';
import 'package:whats_app_clone_clean_arch/data/model/group.dart'as model;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:riverpod/src/provider.dart';
import 'package:whats_app_clone_clean_arch/data/model/status_model.dart';
import '../../domain/entities/my_chat_entity.dart';
import '../../domain/entities/text_message_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasource/firebase_remote_datasource.dart';
import '../model/user_model.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      await remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String?> getCurrentUID()async =>
      await remoteDataSource.getCurrentUID();
  @override
  Future<bool> isSignIn()async =>
      await remoteDataSource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async =>
      await remoteDataSource.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut() async =>
      await remoteDataSource.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      await remoteDataSource.verifyPhoneNumber(phoneNumber);

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async{
    return remoteDataSource.addToMyChat(myChatEntity);
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async
  => remoteDataSource.createOneToOneChatChannel(uid, otherUid);

  @override
  Stream<List<UserEntity>> getAllUsers() =>
      remoteDataSource.getAllUsers();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    return remoteDataSource.getMessages(channelId);
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    return remoteDataSource.getMyChat(uid);
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) =>
      remoteDataSource.getOneToOneSingleUserChannelId(uid, otherUid);

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity,String channelId)async {
    return remoteDataSource.sendTextMessage(textMessageEntity, channelId);
  }

  @override
  Future<String> uploadImageToStorage(File? file, String childName) {
    return remoteDataSource.uploadImageToStorage(file, childName);
  }

  @override
  Stream<UserModel> getSingleUser(String userId) {
    return remoteDataSource.getSingleUser(userId);
  }

  @override
  Future<void> setUserState(bool isOnline) {
    return remoteDataSource.setUserState(isOnline);
  }

  @override
  Future<void> sendImageMessage(TextMessageEntity textMessageEntity, String channelId) {
    return remoteDataSource.sendImageMessage(textMessageEntity, channelId);
  }

  @override
  Future<void> setChatMessageSeen(String messageId, String channelId) {
    return remoteDataSource.setChatMessageSeen(messageId, channelId);
  }

  @override
  Future<void> uploadStatus({required String userName, required String profilePic, required String phoneNumber, required File statusImage}) {
  return remoteDataSource.uploadStatus(userName: userName, profilePic: profilePic, phoneNumber: phoneNumber, statusImage: statusImage);
  }

  @override
  Future<List<Status>> getStatus() {
    return remoteDataSource.getStatus();
  }

  @override
  Future<void> createGroup({required String name, required File profilePic, required List<Contact> selectedContact}) {
   return remoteDataSource.createGroup(name: name, profilePic: profilePic, selectedContact: selectedContact);
  }

  @override
  Stream<List<model.Group>> getChatGroups() {
 return remoteDataSource.getChatGroups();
  }

  @override
  void makeCall(Call senderCallData, Call receiverCallData) {
   return remoteDataSource.makeCall(senderCallData, receiverCallData);
  }

}