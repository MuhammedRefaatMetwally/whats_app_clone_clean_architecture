import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/contact_screen/select_contact_page.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/group_screen/create_group_screen.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/registeration_screen/registeration_screen.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/status_screen/status_screen.dart';
import 'package:whats_app_clone_clean_arch/presentation/widgets/chatting_widgets/single_communication_page.dart';
import 'package:whats_app_clone_clean_arch/presentation/widgets/status_widgets/confirm_status_screen.dart';
import 'common/utils/page_const.dart';
import 'data/model/status_model.dart';
import 'domain/entities/user_entity.dart';


class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.registerScreen:
        {
            return routeBuilder(const RegistrationScreen());
        }

      case PageConst.createGroupScreen:
        {
          if (args is UserEntity) {
            return routeBuilder(CreateGroupScreen(userInfo: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConst.statusScreen:
        {
          if (args is Status) {
            return routeBuilder(StatusScreen(
              status: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConst.confirmStatusScreen:
        {
          if (args is List ) {
            return routeBuilder(ConfirmStatusScreen(file: args[0], userInfo: args[1],

            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConst.singleCommunicationScreen:
        {
          if (args is SingleCommunication) {
            return routeBuilder(SingleCommunicationPage(singleCommunication: args,));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }

      case PageConst.selectContactScreen:
        {
          if (args is UserEntity) {
            return routeBuilder(SelectContactPage(userInfo: args));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }

      default:
        {
          const NoPageFound();
        }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.noPageFound),
      ),
      body: const Center(
        child: Text(AppConst.pageNotFound),
      ),
    );
  }
}
