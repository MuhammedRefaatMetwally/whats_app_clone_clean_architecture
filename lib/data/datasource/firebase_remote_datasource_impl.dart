import 'dart:io';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whats_app_clone_clean_arch/data/local_datasource/local_datasource.dart';
import 'package:whats_app_clone_clean_arch/data/model/group.dart'as model;
import 'package:whats_app_clone_clean_arch/data/model/status_model.dart';
import '../../domain/entities/my_chat_entity.dart';
import '../../domain/entities/text_message_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../model/call.dart';
import '../model/my_chat_model.dart';
import '../model/text_message_model.dart';
import '../model/user_model.dart';
import 'firebase_remote_datasource.dart';

class FirebaseRemoteDataSourceImpl
    implements FirebaseRemoteDataSource, LocalDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final FirebaseDatabase realtime;
  final FirebaseStorage firebaseStorage;
  String _verificationId = "";

  FirebaseRemoteDataSourceImpl({required this.auth,
    required this.fireStore,
    required this.realtime,
    required this.firebaseStorage});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");
    final uid = await getCurrentUID();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        status: user.status,
        profileUrl: user.profileUrl,
        isOnline: user.isOnline,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        name: user.name,
      ).toDocument();

      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String?> getCurrentUID() async => auth.currentUser?.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<String> uploadImageToStorage(File? file, String childName) async {
    Reference ref =
    firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);

    final uploadTask = ref.putFile(file!);

    final imageUrl =
    (await uploadTask.whenComplete(() => {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      if (kDebugMode) {
        print("phone verified : Token ${authCredential.token}");
      }
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      if (kDebugMode) {
        print(
          "phone failed : ${firebaseAuthException
              .message},${firebaseAuthException.code}",
        );
      }
    }

    phoneCodeSent(String verificationId, [int? forceResendingToken]) {
      _verificationId = verificationId;

      if (kDebugMode) {
        print("CODE SENT $verificationId");
      }
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 10),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Future<List<Contact>> getDeviceContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return contacts;
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async {
    final myChatRef = fireStore
        .collection('users')
        .doc(myChatEntity.senderUID)
        .collection('myChat');

    final otherChatRef = fireStore
        .collection('users')
        .doc(myChatEntity.recipientUID)
        .collection('myChat');

    final myNewChat = MyChatModel(
      time: myChatEntity.time,
      senderName: myChatEntity.senderName,
      senderUID: myChatEntity.recipientUID,
      recipientUID: myChatEntity.recipientUID,
      recipientName: myChatEntity.recipientName,
      channelId: myChatEntity.channelId,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      profileURL: myChatEntity.profileURL,
      recentTextMessage: myChatEntity.recentTextMessage,
      recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
      senderPhoneNumber: myChatEntity.senderPhoneNumber,
    ).toDocument();

    final otherNewChat = MyChatModel(
      time: myChatEntity.time,
      senderName: myChatEntity.recipientName,
      senderUID: myChatEntity.recipientUID,
      recipientUID: myChatEntity.senderUID,
      recipientName: myChatEntity.senderName,
      channelId: myChatEntity.channelId,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      profileURL: myChatEntity.profileURL,
      recentTextMessage: myChatEntity.recentTextMessage,
      recipientPhoneNumber: myChatEntity.senderPhoneNumber,
      senderPhoneNumber: myChatEntity.recipientPhoneNumber,
    ).toDocument();

    myChatRef.doc(myChatEntity.recipientUID).get().then((myChatDoc) {
      if (!myChatDoc.exists) {
        //Create
        myChatRef.doc(myChatEntity.recipientUID).set(myNewChat);
        otherChatRef.doc(myChatEntity.senderUID).set(otherNewChat);
        return;
      } else {
        //Update
        myChatRef.doc(myChatEntity.recipientUID).update(myNewChat);
        otherChatRef.doc(myChatEntity.senderUID).update(otherNewChat);
        return;
      }
    });
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async {
    final userCollectionRef = fireStore.collection("users");
    final oneToOneChatChannelRef = fireStore.collection('myChatChannel');

    userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((chatChannelDoc) {
      if (chatChannelDoc.exists) {
        return;
      }
      //if not exists
      final chatChannelId = oneToOneChatChannelRef
          .doc()
          .id;
      var channelMap = {
        "channelId": chatChannelId,
        "channelType": "oneToOneChat",
      };
      oneToOneChatChannelRef.doc(chatChannelId).set(channelMap);

      //currentUser
      userCollectionRef
          .doc(uid)
          .collection("engagedChatChannel")
          .doc(otherUid)
          .set(channelMap);

      //OtherUser
      userCollectionRef
          .doc(otherUid)
          .collection("engagedChatChannel")
          .doc(uid)
          .set(channelMap);

      return;
    });
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) {
    final userCollectionRef = fireStore.collection('users');
    return userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()!['channelId'];
      }
      return Future.value("");
    });
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity,
      String channelId,) async {
    final messageRef = fireStore
        .collection('myChatChannel')
        .doc(channelId)
        .collection('messages');

    final newMessage = TextMessageModel(
      message: textMessageEntity.message,
      messageId: textMessageEntity.messageId,
      messageType: textMessageEntity.messageType,
      recipientName: textMessageEntity.recipientName,
      recipientUID: textMessageEntity.recipientUID,
      sederUID: textMessageEntity.sederUID,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
      isSeen: textMessageEntity.isSeen,
      repliedMessage: textMessageEntity.repliedMessage,
      repliedTo: textMessageEntity.repliedTo,
      repliedMessageType: textMessageEntity.repliedMessageType,
    ).toDocument();

    messageRef
        .doc(
      textMessageEntity.messageId,
    )
        .set(newMessage);
  }

  @override
  Future<void> sendImageMessage(TextMessageEntity textMessageEntity,
      String channelId,) async {
    final messageRef = fireStore
        .collection('myChatChannel')
        .doc(channelId)
        .collection('messages');

    final newMessage = TextMessageModel(
      message: textMessageEntity.message,
      messageId: textMessageEntity.messageId,
      messageType: textMessageEntity.messageType,
      recipientName: textMessageEntity.recipientName,
      recipientUID: textMessageEntity.recipientUID,
      sederUID: textMessageEntity.sederUID,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
      isSeen: textMessageEntity.isSeen,
      repliedMessage: textMessageEntity.repliedMessage,
      repliedTo: textMessageEntity.repliedTo,
      repliedMessageType: textMessageEntity.repliedMessageType,
    ).toDocument();

    messageRef.doc(textMessageEntity.messageId).set(newMessage);
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messagesRef = fireStore
        .collection("myChatChannel")
        .doc(channelId)
        .collection('messages');

    return messagesRef.orderBy('time').snapshots().map(
          (querySnap) =>
          querySnap.docs
              .map((doc) => TextMessageModel.fromSnapShot(doc))
              .toList(),
    );
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    final myChatRef =
    fireStore.collection('users').doc(uid).collection('myChat');

    return myChatRef.orderBy('time', descending: true).snapshots().map(
          (querySnap) =>
          querySnap.docs
              .map((doc) => MyChatModel.fromSnapShot(doc))
              .toList(),
    );
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollectionRef = fireStore.collection("users");
    return userCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docQuerySnapshot) => UserModel.fromSnapshot(docQuerySnapshot))
          .toList();
    });
  }

  @override
  Stream<UserModel> getSingleUser(String userId) {
    return fireStore.collection('users').doc(userId).snapshots().map(
          (event) =>
          UserModel.fromSnapshot(
            event,
          ),
    );
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await fireStore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .update({"isOnline": isOnline});
  }

  @override
  Future<void> setChatMessageSeen(String messageId,
      String channelId,) async {
    await fireStore
        .collection('myChatChannel')
        .doc(channelId)
        .collection('messages')
        .doc(messageId)
        .update({"isSeen": true});
  }

  @override
  Future<void> uploadStatus({
    required String userName,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
  }) async {

   try{
     var statusId = const Uuid().v1();

     final uid = await getCurrentUID();

     final imageUrl =
     await uploadImageToStorage(statusImage, "/status/$statusId$uid");

     final contacts = await getDeviceContacts();
     List<String> uidWhoCanSee = [];
     for (int i = 0; i < contacts.length; i++) {
       var userDataFirebase = await fireStore
           .collection("users")
           .where("phoneNumber",
           isEqualTo: contacts[i].phones[0].normalizedNumber)
           .get();

       if (userDataFirebase.docs.isNotEmpty) {
         var userData = UserModel.fromSnapshot(userDataFirebase.docs[0]);
         uidWhoCanSee.add(userData.uid);
       }
     }
     List<String> statusImageUrls = [];

     var statusesSnapShot = await fireStore
         .collection("status")
         .where("uid", isEqualTo: auth.currentUser?.uid)
         .get();

     if (statusesSnapShot.docs.isNotEmpty) {
       Status status = Status.fromMap(statusesSnapShot.docs[0].data());
       statusImageUrls = status.photoUrl;
       statusImageUrls.add(imageUrl);
       await fireStore
           .collection("status")
           .doc(statusesSnapShot.docs[0].id)
           .update({"photoUrl": statusImageUrls});
       return;
     } else {
       statusImageUrls = [imageUrl];
     }

     Status status = Status(
         uid: uid,
         username: userName,
         phoneNumber: phoneNumber,
         photoUrl: statusImageUrls,
         createdAt: DateTime.now(),
         profilePic: profilePic,
         statusId: statusId,
         whoCanSee: uidWhoCanSee);

     await fireStore.collection("status").doc(statusId).set(status.toMap());
   }catch(e){
     print("ERROR ${e.toString()}");
   }
  }

  @override
  Future<List<Status>> getStatus() async {
    List<Status> status = [];
    final contacts = await getDeviceContacts();

    for (int i = 0; i < contacts.length; i++) {
      var statuesSnapshots = await fireStore
          .collection("status")
          .where("phoneNumber",
          isEqualTo: contacts[i].phones[0].normalizedNumber).where(
          "createdAt", isGreaterThan:DateTime.now().subtract(const Duration(hours:24)).millisecondsSinceEpoch)
          .get();
      for(var tempData in statuesSnapshots.docs){
        Status tempStatus =Status.fromMap(tempData.data());
         if(tempStatus.whoCanSee.contains(auth.currentUser?.uid)){
           status.add(tempStatus);
         }
      }
    }
    return status;

  }

  @override
  Future<void> createGroup({required String name, required File profilePic,
    required List<Contact> selectedContact}) async {
    List<String> uids = [];
    for (int i = 0; i < selectedContact.length; i++) {
      var userCollection = await fireStore
          .collection('users')
          .where(
        'phoneNumber',
        isEqualTo: selectedContact[i].phones[0].number.replaceAll(
          ' ',
          '',
        ),
      )
          .get();

      if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
        uids.add(userCollection.docs[0].data()['uid']);
      } 
    }
    var groupId = const Uuid().v1();

    String profileUrl = await uploadImageToStorage(profilePic, 'group/$groupId');

    model.Group group = model.Group(
      senderId: auth.currentUser!.uid,
      name: name,
      groupId: groupId,
      lastMessage: '',
      groupPic: profileUrl,
      membersUid: [auth.currentUser!.uid, ...uids],
      timeSent: DateTime.now(),
    );
       print(uids);
    await fireStore.collection('groups').doc(groupId).set(group.toMap());
  }

  @override
  Stream<List<model.Group>> getChatGroups() {
    return fireStore.collection('groups').snapshots().map((event) {
      List<model.Group> groups = [];
      for (var document in event.docs) {
        var group = model.Group.fromMap(document.data());
        if (group.membersUid.contains(auth.currentUser!.uid)) {
          groups.add(group);
        }
      }
      return groups;
    });
  }

  Stream<DocumentSnapshot> get callStream =>
      fireStore.collection('call').doc(auth.currentUser!.uid).snapshots();

  @override
  void makeCall(Call senderCallData, Call receiverCallData,) async {

      await fireStore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      await fireStore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());

  }
}
