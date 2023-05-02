import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone_clean_arch/presentation/widgets/chat_widgets/single_item_chat_user_page.dart';

import '../../bloc/group/group_cubit.dart';

class GroupChatList extends StatelessWidget {
  const GroupChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<GroupCubit, GroupState>(
      builder: (context, groupState) {
        if(groupState is GroupLoaded){
          final groupData=groupState.groups;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: groupData.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {},
                child: SingleItemChatUserPage(
                  name: groupData[index].name,
                  recentSendMessage: groupData[index].lastMessage,
                  time:
                  DateFormat('hh:mm a').format(groupData[index].timeSent),
                  profileUrl: groupData[index].groupPic,
                ),
              );
            },
          );
        }
        return const SizedBox();
      },

    );
  }
}
