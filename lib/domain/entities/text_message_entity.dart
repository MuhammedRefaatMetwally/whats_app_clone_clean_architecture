import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import '../../common/enums/message_enum.dart';

class TextMessageEntity extends Equatable {
  final String senderName;
  final String sederUID;
  final String recipientName;
  final String recipientUID;
  final MessageEnum messageType;
  final String message;
  final String messageId;
  final Timestamp time;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;

  const TextMessageEntity(
      {required this.messageType,
      required this.senderName,
      required this.sederUID,
      required this.recipientName,
      required this.recipientUID,
      required this.message,
      required this.messageId,
      required this.time,
      required this.isSeen,
      required this.repliedMessage,
      required this.repliedTo,
      required this.repliedMessageType});

  @override
  List<Object> get props => [
        senderName,
        sederUID,
        recipientName,
        recipientUID,
        messageType,
        message,
        messageId,
        time,
        isSeen,
        repliedMessage,
        repliedTo,
        repliedMessageType,
      ];
}
