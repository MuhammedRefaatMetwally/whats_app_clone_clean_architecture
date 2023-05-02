import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';

import '../../common/enums/message_enum.dart';

class ChatMessage {
  String text;
  String time;
  Color color;
  TextAlign align;
  BubbleNip nip;
  CrossAxisAlignment crossAlign;
  MessageEnum messageEnum;
  VoidCallback? onLeftSwipe;
  VoidCallback? onRightSwipe;
  String repliedText;
  String username;
  MessageEnum repliedMessageType;
  bool isSeen;
  bool? senderMessage;

  ChatMessage(
      {required this.text,
      required this.time,
      required this.color,
      required this.align,
      required this.nip,
      required this.crossAlign,
      required this.messageEnum,
       this.onLeftSwipe,
       this.onRightSwipe,
      required this.repliedText,
      required this.username,
      required this.repliedMessageType,
      required this.isSeen,
       this.senderMessage});
}
