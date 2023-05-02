import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/chat_page/widgets/emty_list_widget.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/chat_page/widgets/single_item_chat_user_page.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/my_chat/my_chat_cubit.dart';
import '../../../bloc/user/user_cubit.dart';
import '../../../widgets/global/loader.dart';
import '../../contact_page/chatting_widgets/single_communication_page.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key, required this.myChatData, required this.userInfo}) : super(key: key);
 final MyChatLoaded myChatData;
  final UserEntity userInfo;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserEntity>>(
        stream: BlocProvider.of<UserCubit>(context).getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return snapshot.data!.isEmpty
              ? const EmptyList()
              : ListView.builder(
            shrinkWrap: true,
            itemCount: myChatData.myChat.length,
            itemBuilder: (_, index) {
              final dbUsers = snapshot.data
                  ?.where((user) => user.uid != userInfo.uid)
                  .toList();
              final myChat = myChatData.myChat[index];

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.singleCommunicationScreen,arguments:SingleCommunication(
                    senderPhoneNumber: myChat.senderPhoneNumber,
                    senderUID: userInfo.uid,
                    senderName: myChat.senderName,
                    recipientUID: myChat.recipientUID,
                    recipientPhoneNumber:
                    myChat.recipientPhoneNumber,
                    recipientName: myChat.recipientName,
                    profileUrl: myChat.profileURL, isGroupChat: false,
                  ),);
                  BlocProvider.of<MyChatCubit>(context).setMessageSeen(
                      myChat.channelId, myChat.recipientUID);
                },
                child: SingleItemChatUserPage(
                  name: myChat.recipientName,
                  recentSendMessage: myChat.recentTextMessage,
                  time:
                  DateFormat('hh:mm a').format(myChat.time.toDate()),
                  profileUrl: dbUsers![index].profileUrl,
                ),
              );
            },
          );
        });
  }
}
