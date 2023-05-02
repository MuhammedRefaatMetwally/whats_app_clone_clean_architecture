import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/contact_page/chatting_widgets/list_messages.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/contact_page/chatting_widgets/send_message_text_field.dart';
import '../../../../common/utils/app_const.dart';
import '../../../../data/model/chat_body_model.dart';

class ChatBodyWidget extends StatelessWidget {
  const ChatBodyWidget({Key? key,required this.chatBodyModel, required this.singleCommunication}) : super(key: key);
 final ChatBodyModel chatBodyModel;
 final SingleCommunication singleCommunication;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(AppConst.backGroundWallpaper,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            MessagesList( messages:chatBodyModel.messages, senderUid: chatBodyModel.senderUid, scrollController: chatBodyModel.scrollController,),
            SendTextMessageField(scrollController: chatBodyModel.scrollController, singleCommunication: singleCommunication,),
          ],
        )
      ],
    );
  }
}
