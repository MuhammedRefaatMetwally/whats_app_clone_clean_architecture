import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/domain/entities/user_entity.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/group/group_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/group_page/widgets/select_contacts_group.dart';
import '../../../common/utils/palette.dart';
import '../../../common/utils/utils.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key, required this.userInfo}) : super(key: key);
final UserEntity userInfo;
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  File? image;
  List<Contact> selectedContact=[];
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void createGroup() {
    if (groupNameController.text
        .trim()
        .isNotEmpty && image != null) {
      BlocProvider.of<GroupCubit>(context).createGroup(
          name: groupNameController.text.trim(), profilePic: image!,
          selectedContact: selectedContact);
      /*selectedContact=[];*/
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.createGroup),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                  backgroundImage: NetworkImage(
                    AppConst.networkImage2,
                  ),
                  radius: 64,
                )
                    : CircleAvatar(
                  backgroundImage: FileImage(
                    image!,
                  ),
                  radius: 64,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: groupNameController,
                decoration: const InputDecoration(
                  hintText: AppConst.enterGroupName,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                AppConst.selectContacts,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
             SelectContactsGroup(userInfo: widget.userInfo,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: Palette.tabColor,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
