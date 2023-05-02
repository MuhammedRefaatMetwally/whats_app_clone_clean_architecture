import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/user/user_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/chat_page/widgets/chat_lis.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/chat_page/widgets/group_list.dart';
import '../../../common/utils/palette.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/my_chat/my_chat_cubit.dart';
import '../../widgets/global/loader.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;

  const ChatPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  List<UserEntity> users = [];

  @override
  void initState() {
    BlocProvider.of<MyChatCubit>(context).getMyChat(uid: widget.userInfo.uid);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<UserCubit>(context).setUserStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        BlocProvider.of<UserCubit>(context).setUserStatus(false);
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyChatCubit, MyChatState>(
        builder: (_, myChatState) {
          if (myChatState is MyChatLoaded) {
            return ListView(
              children: [
                const GroupChatList(),
                ChatList(
                  myChatData: myChatState,
                  userInfo: widget.userInfo,
                ),
              ],
            );
          }
          return const Loader();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Palette.primaryColor,
        onPressed: () =>Navigator.pushNamed(context, PageConst.selectContactScreen,arguments: widget.userInfo),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
