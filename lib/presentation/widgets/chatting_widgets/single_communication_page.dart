import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/data/model/chat_body_model.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/upload_image_to_storage_use_case.dart';
import 'package:whats_app_clone_clean_arch/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/enums/message_enum.dart';
import 'package:whats_app_clone_clean_arch/data/model/user_model.dart';
import '../../../../data/model/message_reply.dart';
import '../../../../data/model/single_communication_model.dart';
import '../../../../common/utils/utils.dart';
import '../../bloc/communication/communication_cubit.dart';
import '../../bloc/user/get_single_user/get_single_user_cubit.dart';
import 'chat_body_widget.dart';



class SingleCommunicationPage extends ConsumerStatefulWidget {
  final SingleCommunication singleCommunication;
  const SingleCommunicationPage(
      {Key? key,required this.singleCommunication})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState
    extends ConsumerState<SingleCommunicationPage> {
  final ScrollController _scrollController = ScrollController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;

  bool isRecording = false;

  @override
  void initState() {
    BlocProvider.of<CommunicationCubit>(context).getMessages(
      senderId: widget.singleCommunication.senderUID,
      recipientId:  widget.singleCommunication.recipientUID,
    );

    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    super.initState();
  }

  void onMessageSwipe(String message, bool isMe, MessageEnum messageEnum) {
    ref
        .read(messageReplyProvider.state)
        .update((state) => MessageReply(message, isMe, messageEnum));
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(AppConst.micPermissionNotAllowed);
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  void selectImage(MessageReply? messageReply) async {
    File? image = await pickImageFromGallery(context);
    di.sl<UploadImageToStorageUseCase>()
        .call(image, AppConst.imageMessages)
        .then((value) {
      if (image != null) {
        BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
          senderName:  widget.singleCommunication.senderName,
          senderId:  widget.singleCommunication.senderUID,
          recipientId:  widget.singleCommunication.recipientUID,
          recipientName:  widget.singleCommunication.recipientName,
          message: value,
          recipientPhoneNumber:  widget.singleCommunication.recipientPhoneNumber,
          senderPhoneNumber:  widget.singleCommunication.senderPhoneNumber,
          messageEnum: MessageEnum.image,
          profileUrl:  widget.singleCommunication.profileUrl,
          isSeen: false,
          messageReply: messageReply,
        );
      }
    });
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void selectGIF(MessageReply? messageReply) async {
    final gif = await pickGIF(context);
    int gifUrlPartIndex = gif!.url.lastIndexOf("-") + 1;
    String gifUrlPart = gif.url.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
      senderName:  widget.singleCommunication.senderName,
      senderId:  widget.singleCommunication.senderUID,
      recipientId:  widget.singleCommunication.recipientUID,
      recipientName:  widget.singleCommunication.recipientName,
      message: newGifUrl,
      recipientPhoneNumber:  widget.singleCommunication.recipientPhoneNumber,
      senderPhoneNumber:  widget.singleCommunication.senderPhoneNumber,
      messageEnum: MessageEnum.gif,
      profileUrl:  widget.singleCommunication.profileUrl,
      isSeen: false,
      messageReply: messageReply,
    );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void selectVideo(MessageReply? messageReply) async {
    File? video = await pickVideoFromGallery(context);
    di
        .sl<UploadImageToStorageUseCase>()
        .call(video, AppConst.videoMessages)
        .then((value) {
      if (video != null) {
        BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
          senderName:  widget.singleCommunication.senderName,
          senderId:  widget.singleCommunication.senderUID,
          recipientId:  widget.singleCommunication.recipientUID,
          recipientName:  widget.singleCommunication.recipientName,
          message: value,
          recipientPhoneNumber:  widget.singleCommunication.recipientPhoneNumber,
          senderPhoneNumber:  widget.singleCommunication.senderPhoneNumber,
          messageEnum: MessageEnum.video,
          profileUrl:  widget.singleCommunication.profileUrl,
          isSeen: false,
          messageReply: messageReply,
        );
      }
    });
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: StreamBuilder<UserModel>(
              stream: BlocProvider.of<GetSingleUserCubit>(context)
                  .getSingleUsers(userId:  widget.singleCommunication.recipientUID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                     SizedBox(
                      width: 8.w,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.profileUrl),
                      radius: 24.r,
                    ),
                     SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!.name,
                          style:  TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          snapshot.data!.isOnline
                              ? AppConst.online
                              : AppConst.offline,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                onTap: () => BlocProvider.of<CommunicationCubit>(context)
                    .makeCall(
                        receiverName:  widget.singleCommunication.recipientName,
                        receiverUid:  widget.singleCommunication.recipientUID,
                        receiverProfilePic:  widget.singleCommunication.profileUrl,
                        callerId:  widget.singleCommunication.senderUID,
                        callerName:  widget.singleCommunication.senderName,
                        callerPic:
                            FirebaseAuth.instance.currentUser!.photoURL!),
                child: const Icon(Icons.videocam)),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.call),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.more_vert),
          ],
        ),
        body: BlocBuilder<CommunicationCubit, CommunicationState>(
          builder: (context, communicationState) {
            if (communicationState is CommunicationLoaded) {
              return ChatBodyWidget(
                chatBodyModel: ChatBodyModel(
                  messages: communicationState.messages,
                  scrollController: _scrollController,
                  senderUid:  widget.singleCommunication.senderUID,
                ), singleCommunication: widget.singleCommunication,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
