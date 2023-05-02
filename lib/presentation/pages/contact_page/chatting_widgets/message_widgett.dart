import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whats_app_clone_clean_arch/data/model/chat_message_model.dart';
import '../../../../common/utils/palette.dart';
import '../widgets/display_text_image_gif.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.chatMessage}) : super(key: key);
 final ChatMessage chatMessage;
  @override
  Widget build(BuildContext context) {
    final isReplying = chatMessage.repliedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe:chatMessage.onLeftSwipe,
      onRightSwipe: chatMessage.onRightSwipe,
      child: Column(
        crossAxisAlignment: chatMessage.crossAlign,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.90,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(3),
              child: Bubble(
                color: chatMessage.color,
                nip: chatMessage.nip,
                child: Column(
                  crossAxisAlignment: chatMessage.crossAlign,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        if (isReplying) ...[
                          Text(
                            chatMessage.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Palette.backgroundColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: DisplayTextImageGIF(
                              message: chatMessage.repliedText,
                              type: chatMessage.repliedMessageType,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        DisplayTextImageGIF(
                          message: chatMessage.text,
                          type: chatMessage.messageEnum,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            chatMessage.time,
                            textAlign:chatMessage.align,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          chatMessage.senderMessage!
                              ? Icon(
                            chatMessage.isSeen ? Icons.done_all : Icons.done,
                            size: 20,
                            color: chatMessage.isSeen ? Colors.blue : Colors.white60,
                          )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
