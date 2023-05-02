import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/status/status_cubit.dart';
import '../../../../common/utils/palette.dart';
import '../../../../domain/entities/user_entity.dart';

class ConfirmStatusScreen extends StatelessWidget {
  final File file;
  final UserEntity userInfo;

  const ConfirmStatusScreen({
    Key? key,
    required this.file,
    required this.userInfo,
  }) : super(key: key);

 void sendStatus(BuildContext context){
   BlocProvider.of<StatusCubit>(context).uploadStatus(
       userName: userInfo.name,
       profilePic: userInfo.profileUrl,
       phoneNumber: userInfo.phoneNumber,
       statusImage: file);
   Navigator.pop(context);
 }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Image.file(file),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:()=>sendStatus(context),
            backgroundColor: Palette.greenColor,
            child: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
