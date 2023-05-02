import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/domain/entities/user_entity.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/upload_image_to_storage_use_case.dart';
import 'package:whats_app_clone_clean_arch/injection_container.dart' as di;
import 'package:whats_app_clone_clean_arch/presentation/bloc/auth/auth_cubit.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/auth/auth_cubit.dart';
import '../../../common/utils/palette.dart';
import '../../../common/utils/utils.dart';
import '../../bloc/phone_auth/phone_auth_cubit.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController _nameController = TextEditingController();

  File? image;
  String? imageUrl;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);

    di.sl<UploadImageToStorageUseCase>()
        .call(
      image!,
      "profileImage",
    ).then((imageUrl) {
      this.imageUrl = imageUrl;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(AppConst.profileInfo,
                    style: TextStyle(
                      color:  Palette.greenColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    AppConst.pleaseProvideName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                         AppConst.networkImage,
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.85,
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: AppConst.enterYourName,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _submitProfileInfo(image: imageUrl!),
                        icon: const Icon(
                          Icons.done,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitProfileInfo({required String image}) {
    if (_nameController.text.isNotEmpty) {
      BlocProvider.of<PhoneAuthCubit>(context).submitProfileInfo(
        user: UserEntity(
            name: _nameController.text,
            email: "",
            phoneNumber: widget.phoneNumber,
            isOnline: true,
            uid: "",
            profileUrl: image),
      );
    }
  }
}
