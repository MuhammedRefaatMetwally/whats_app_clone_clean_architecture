import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/get_device_number/get_device_numbers_cubit.dart';
import '../../bloc/user/user_cubit.dart';
import '../../widgets/contact_widgets/list_contacts.dart';
import '../../widgets/contact_widgets/list_invite_contacts.dart';
import '../../widgets/contact_widgets/new_contact_button_widget.dart';
import '../../widgets/contact_widgets/new_group_button_widgett.dart';

class SelectContactPage extends StatelessWidget {
  SelectContactPage({Key? key, required this.userInfo}) : super(key: key);

  final UserEntity userInfo;
  List<UserEntity> users = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDeviceNumbersCubit, GetDeviceNumbersState>(
      builder: (context, contactNumberState) {
        if (contactNumberState is GetDeviceNumbersLoaded) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                final List<Contact> contacts = [];
                List<Contact> inviteContacts = [];

                final dbUsers = userState.users
                    .where((user) => user.uid != userInfo.uid)
                    .toList();

                for (var deviceUserNumber in contactNumberState.contacts) {
                  for (var dbUser in dbUsers) {
                    if (dbUser.phoneNumber ==
                        deviceUserNumber.phones[0].normalizedNumber) {
                      contacts.add(Contact(
                        id: dbUser.uid,
                        phones: [Phone(dbUser.phoneNumber)],
                        displayName: dbUser.name,
                      ));
                    } else {
                      inviteContacts = contactNumberState.contacts
                          .where((element) =>
                              element.phones[0].normalizedNumber !=
                              dbUser.phoneNumber)
                          .toList();
                    }
                  }
                }

                users = dbUsers;

                return Scaffold(
                  appBar: AppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppConst.selectContacts),
                        Text(
                          "${contacts.length} ${AppConst.contacts}",
                          style:  TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                    actions: const [
                      Icon(Icons.search),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  body: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NewGroupButtonWidget(),
                         SizedBox(
                          height: 8.h,
                        ),
                       const NewContactButtonWidget(),
                         SizedBox(
                          height: 8.h,
                        ),
                        const Text(
                          AppConst.contactsOnWhatsApp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        ListContacts(
                          contacts: contacts,
                          userInfo: userInfo,
                          users: users,
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        const Text(
                          AppConst.inviteToWhatsApp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        ListInviteContacts(
                          contacts: inviteContacts,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            },
          );
        }
        return Container();
      },
    );
  }


}
