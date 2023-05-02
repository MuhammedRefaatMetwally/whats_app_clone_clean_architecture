import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'dart:io';
import '../../common/enums/message_enum.dart';
import '../../domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  const TextMessageModel({
    required String senderName,
    required String sederUID,
    required String recipientName,
    required String recipientUID,
    required MessageEnum messageType,
    required String message,
    required String messageId,
    required Timestamp time,
    required bool isSeen,
    required String repliedMessage,
    required String repliedTo,
    required MessageEnum repliedMessageType,
  }) : super(
            senderName: senderName,
            sederUID: sederUID,
            recipientName: recipientName,
            recipientUID: recipientUID,
            messageType: messageType,
            message: message,
            messageId: messageId,
            time: time,
            isSeen: isSeen,
            repliedMessage: repliedMessage,
            repliedTo: repliedTo,
            repliedMessageType: repliedMessageType);

  factory TextMessageModel.fromSnapShot(DocumentSnapshot snapshot) {
    return TextMessageModel(
      senderName: snapshot['senderName'],
      sederUID: snapshot['sederUID'],
      recipientName: snapshot['recipientName'],
      recipientUID: snapshot['recipientUID'],
      messageType: (snapshot["messageType"] as String).toEnum(),
      message: snapshot['message'],
      messageId: snapshot['messageId'],
      time: snapshot['time'],
      isSeen: snapshot["isSeen"],
      repliedMessage: snapshot["repliedMessage"],
      repliedTo: snapshot["repliedTo"],
      repliedMessageType: (snapshot["repliedMessageType"] as String).toEnum(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "sederUID": sederUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "messageType": messageType.type,
      "message": message,
      "messageId": messageId,
      "isSeen": isSeen,
      "time": time,
      "repliedMessage": repliedMessage,
      "repliedTo": repliedTo,
      "repliedMessageType": repliedMessageType.type,
    };
  }
}
