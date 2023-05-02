import 'dart:async';
import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone_clean_arch/data/model/chat_message_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/contact_page/chatting_widgets/message_widgett.dart';
import '../../../../common/enums/message_enum.dart';
import '../../../../data/model/message_reply.dart';
import '../../../../domain/entities/text_message_entity.dart';
import '../../../bloc/my_chat/my_chat_cubit.dart';

class MessagesList extends ConsumerStatefulWidget {
  const MessagesList(
      {Key? key, required this.messages, required this.senderUid,required this.scrollController,}) : super(key: key);

  final ScrollController scrollController;
  final List<TextMessageEntity> messages;
  final String senderUid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>_MessagesList();
}
class _MessagesList extends ConsumerState<MessagesList> {

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 100), () {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInQuad,
      );
    });

    return Expanded(
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.messages.length,
        itemBuilder: (_, index) {
          final message = widget.messages[index];
          if(!message.isSeen&&message.recipientUID==FirebaseAuth.instance.currentUser!.uid){
            BlocProvider.of<MyChatCubit>(context).setMessageSeen(message.messageId,message.recipientUID );
          }
          if (message.sederUID == widget.senderUid) {
            return MessageWidget(chatMessage:
            ChatMessage(
              color: Colors.lightGreen[400]!,
              time: DateFormat('hh:mm a').format(message.time.toDate()),
              align: TextAlign.left,
              crossAlign: CrossAxisAlignment.end,
              nip: BubbleNip.rightTop,
              text: message.message,
              messageEnum: message.messageType,
              onLeftSwipe: () => onMessageSwipe(message.message, true, message.messageType),
              repliedText: message.repliedMessage,
              username: message.repliedTo,
              repliedMessageType: message.repliedMessageType,
              isSeen: message.isSeen,
              senderMessage: message.sederUID == widget.senderUid,),
            );
          } else {
            return MessageWidget(chatMessage:
            ChatMessage(
              color: Colors.white,
              time: DateFormat('hh:mm a').format(message.time.toDate()),
              align: TextAlign.left,
              crossAlign: CrossAxisAlignment.start,
              nip: BubbleNip.leftTop,
              text: message.message,
              messageEnum: message.messageType,
              onRightSwipe: () => onMessageSwipe(message.message, false, message.messageType),
              repliedText: message.repliedMessage,
              username: message.repliedTo,
              repliedMessageType: message.repliedMessageType,
              isSeen: message.isSeen,
              senderMessage: false,),
            );
          }
        },
      ),
    );
  }
    void onMessageSwipe(String message, bool isMe, MessageEnum messageEnum) {
      ref.read(messageReplyProvider.state).update((state) => MessageReply(message, isMe, messageEnum));
    }


}
