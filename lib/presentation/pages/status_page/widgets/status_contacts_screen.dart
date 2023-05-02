import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/status/status_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/status_page/widgets/confirm_status_screen.dart';
import '../../../../common/utils/palette.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../common/utils/utils.dart';
import '../status_screen.dart';

class StatusContactsScreen extends StatelessWidget {
  const StatusContactsScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  final UserEntity userInfo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusState>(
      builder: (context, statusState) {
        if (statusState is StatusLoaded) {
          final status = statusState.status;
          return Scaffold(
            body: ListView.builder(
              itemCount: status.length,
              itemBuilder: (context,index) {
                var statusData = status[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () =>Navigator.pushNamed(context, PageConst.statusScreen,arguments: statusData),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            statusData.username,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Divider(color:  Palette.dividerColor),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              statusData.profilePic,
                            ),
                            radius: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  File? pickedImage = await pickImageFromGallery(context);
                  if (pickedImage != null) {
                    Navigator.pushNamed(context, PageConst.confirmStatusScreen,arguments: [pickedImage,userInfo]);
                  }
                },
                child: const Icon(Icons.camera_alt)),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
