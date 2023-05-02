import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/group_page/create_group_screen.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/home_screen/widgets/search_widget.dart';
import '../../../common/utils/palette.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/home/home_cubit.dart';
import '../../pages/calls_page/calls_page.dart';
import '../../pages/camera_page/camera_page.dart';
import '../../pages/chat_page/chat_page.dart';
import '../../pages/status_page/status_screen.dart';
import '../../pages/status_page/widgets/status_contacts_screen.dart';
import '../../widgets/global/custom_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity userInfo;
  final List<CameraDescription>? cameras;
  HomeScreen({Key? key, required this.userInfo,  this.cameras}) : super(key: key);

  final PageController _pageViewController = PageController(initialPage: 1);

  List<Widget> get _pages => [
        CameraPage(cameras: cameras!),
        ChatPage(
          userInfo: userInfo,),
         StatusContactsScreen(userInfo: userInfo,),
        const CallsPage(),
      ];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.i(context);
        return Scaffold(
          appBar: cubit.currentPageIndex != 0
              ? AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  backgroundColor: cubit.isSearch == false
                      ?  Palette.primaryColor
                      : Colors.transparent,
                  title: cubit.isSearch == false
                      ? const Text(AppConst.whatsAppClone)
                      : const SizedBox(),
                  flexibleSpace: cubit.isSearch == false
                      ? const SizedBox()
                      : const SearchWidget(),
                  actions: <Widget>[
                    InkWell(
                        onTap: () => cubit.onSearching(),
                        child: const Icon(Icons.search)),
                    const SizedBox(
                      width: 5,
                    ),
                    PopupMenuButton(itemBuilder: (context)=>[
                       PopupMenuItem(child: const Text(AppConst.createGroup),
                         onTap: ()=>Future(()=>Navigator.pushNamed(context, PageConst.createGroupScreen,arguments: userInfo))
                         //wrap it with future cuz popupMenu when u navigate it does no dismiss itself so it pops what it navigates
                      ,)
                    ],
                    )],
                )
              : null,
          body: Column(
            children: <Widget>[
              cubit.isSearch == false
                  ? cubit.currentPageIndex != 0
                      ? CustomTabBar(index: cubit.currentPageIndex)
                      : const SizedBox()
                  : const SizedBox(),
              Expanded(
                child: PageView.builder(
                  itemCount: _pages.length,
                  controller: _pageViewController,
                  onPageChanged: (index) => cubit.onPageChanged(index),
                  itemBuilder: (_, index) {
                    return _pages[index];
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
