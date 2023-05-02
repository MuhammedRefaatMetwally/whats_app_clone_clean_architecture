import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:whats_app_clone_clean_arch/common/helper/show_alert_dialog.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/domain/entities/user_entity.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/user/user_cubit.dart';
import '../../../widgets/global/loader.dart';

class SelectContactsGroup extends StatefulWidget {
  const SelectContactsGroup({Key? key, required this.userInfo}) : super(key: key);
 final UserEntity userInfo;
  @override
  State<StatefulWidget> createState() => _SelectContactsGroupState();
}

class _SelectContactsGroupState extends State<SelectContactsGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDeviceNumbersCubit, GetDeviceNumbersState>(
      builder: (context, contactState) {
        if (contactState is GetDeviceNumbersLoaded) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
             if(userState is UserLoaded){
               final List<Contact> contacts = [];
               final dbUsers = userState.users
                   .where((user) => user.uid != widget.userInfo.uid)
                   .toList();

               for (var deviceUserNumber in contactState.contacts) {
                 for (var dbUser in dbUsers) {
                   if (dbUser.phoneNumber ==
                       deviceUserNumber.phones[0].normalizedNumber) {
                     contacts.add(Contact(
                       id: dbUser.uid,
                       phones: [Phone(dbUser.phoneNumber)],
                       displayName: dbUser.name,
                     ));
                   }
                 }
               }
                   return Expanded(
                 child: ListView.builder(
                     itemCount: contacts.length,
                     itemBuilder: (context, index) {
                       final contact = contacts[index];
                       return InkWell(
                         onTap: () => selectContact(index, contact),
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 8),
                           child: ListTile(
                             title: Text(
                               contact.displayName,
                               style: const TextStyle(
                                 fontSize: 18,
                               ),
                             ),
                             leading: selectedContactsIndex.contains(index)
                                 ? IconButton(
                               onPressed: () =>
                                   showAlertDialog(
                                       context: context,
                                       message: AppConst.groupChattingNotValid),
                               icon: const Icon(Icons.done),
                             )
                                 : null,
                           ),
                         ),
                       );
                     }),
               );
             }
             return const Loader();
            },
          );
        }
        return const Loader();
      },
    );
  }
}
