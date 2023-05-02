import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/contact_page/chatting_widgets/single_communication_page.dart';

import '../../../../common/helper/show_alert_dialog.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/user/user_cubit.dart';

class ListContacts extends StatelessWidget {
  const ListContacts({Key? key, required this.contacts, required this.userInfo, required this.users}) : super(key: key);
  final List<Contact> contacts;
  final UserEntity userInfo;
  final List<UserEntity> users;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              try {
                bool isFound = false;
                for (var user in users) {
                  if (user.phoneNumber == contacts[index].phones[0].number) {
                    isFound = true;
                    Navigator.pushNamed(context, PageConst.singleCommunicationScreen,arguments: SingleCommunication(
                      recipientName: contacts[index].displayName,
                      recipientPhoneNumber:
                      contacts[index].phones[0].number,
                      recipientUID: contacts[index].id,
                      senderName: userInfo.name,
                      senderUID: userInfo.uid,
                      senderPhoneNumber:
                      userInfo.phoneNumber,
                      profileUrl:user.profileUrl,
                      isGroupChat: false,
                    ),);
                  }
                }
                if (!isFound) {
                  showAlertDialog(
                      context: context,
                      message: AppConst.thisNumberExists);
                }
              } catch (e) {
                showAlertDialog(
                    context: context, message: AppConst.invalidContactNumber);
              }

              BlocProvider.of<UserCubit>(context).createChatChannel(
                  uid: userInfo.uid, otherUid: contacts[index].id);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(users[index].profileUrl),
                        radius: 28,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contacts[index].displayName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            AppConst.welcomeWhatsAppText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
