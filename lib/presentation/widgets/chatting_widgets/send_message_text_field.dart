import 'dart:io';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import 'package:whats_app_clone_clean_arch/injection_container.dart' as di;
import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';
import '../../../../common/utils/utils.dart';
import '../../../../data/model/message_reply.dart';
import '../../../../domain/usecases/upload_image_to_storage_use_case.dart';
import '../../bloc/communication/communication_cubit.dart';
import '../contact_widgets/message_reply_preview.dart';

class SendTextMessageField extends ConsumerStatefulWidget {
  const SendTextMessageField( {Key? key,required this.scrollController,required this.singleCommunication,}) : super(key: key);
  final ScrollController scrollController;
  final SingleCommunication singleCommunication;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>_SendTextMessageField();

}
class _SendTextMessageField extends ConsumerState<SendTextMessageField> {
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  final bool isShowMessageReply=false;
  final TextEditingController _textMessageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  @override
  void initState() {
    _textMessageController.addListener(() {
      setState(() {});
    });
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    super.initState();
  }


  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(AppConst.micPermissionNotAllowed);
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }
  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();
  @override
  void dispose() {
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
    widget.scrollController.dispose();
  }

  void selectImage(MessageReply? messageReply) async {
    File? image = await pickImageFromGallery(context);
    di.sl<UploadImageToStorageUseCase>()
        .call(image, AppConst.imageMessages)
        .then((value) {
      if (image != null) {
        BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
          senderName: widget.singleCommunication.senderName,
          senderId:widget.singleCommunication.senderUID,
          recipientId: widget.singleCommunication.recipientUID,
          recipientName:widget.singleCommunication.recipientName,
          message: value,
          recipientPhoneNumber: widget.singleCommunication.recipientPhoneNumber,
          senderPhoneNumber: widget.singleCommunication.senderPhoneNumber,
          messageEnum: MessageEnum.image,
          profileUrl: widget.singleCommunication.profileUrl,
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
      senderName: widget.singleCommunication.senderName,
      senderId: widget.singleCommunication.senderUID,
      recipientId: widget.singleCommunication.recipientUID,
      recipientName: widget.singleCommunication.recipientName,
      message: newGifUrl,
      recipientPhoneNumber: widget.singleCommunication.recipientPhoneNumber,
      senderPhoneNumber: widget.singleCommunication.senderPhoneNumber,
      messageEnum: MessageEnum.gif,
      profileUrl: widget.singleCommunication.profileUrl,
      isSeen: false,
      messageReply: messageReply,
    );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void selectVideo(MessageReply? messageReply) async {
    File? video = await pickVideoFromGallery(context);
    di.sl<UploadImageToStorageUseCase>()
        .call(video, AppConst.videoMessages)
        .then((value) {
      if (video != null) {
        BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
          senderName: widget.singleCommunication.senderName,
          senderId: widget.singleCommunication.senderUID,
          recipientId: widget.singleCommunication.recipientUID,
          recipientName: widget.singleCommunication.recipientName,
          message: value,
          recipientPhoneNumber: widget.singleCommunication.recipientPhoneNumber,
          senderPhoneNumber: widget.singleCommunication.senderPhoneNumber,
          messageEnum: MessageEnum.video,
          profileUrl: widget.singleCommunication.profileUrl,
          isSeen: false,
          messageReply: messageReply,
        );
      }
    });
    ref.read(messageReplyProvider.state).update((state) => null);
  }


  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Container(
      margin:  EdgeInsets.only(bottom: 8.h, left: 4.w, right: 4.w),
      child: Column(
        children: [
          isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.all(Radius.circular(80.r)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(0.0, 0.50),
                            spreadRadius: 1,
                            blurRadius: 1),
                      ]),
                  child: Row(
                    children: [
                       SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                        onTap: toggleEmojiKeyboardContainer,
                        child: Icon(
                          isShowEmojiContainer
                              ? Icons.keyboard_alt_outlined
                              : Icons.insert_emoticon,
                          color: Colors.grey[500],
                        ),
                      ),
                       SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                        onTap: () => selectGIF(messageReply),
                        child: Icon(
                          Icons.gif,
                          size: 40,
                          color: Colors.grey[500],
                        ),
                      ),
                       SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints:  BoxConstraints(
                            maxHeight: 64.h,
                          ),
                          child: Scrollbar(
                            child: TextField(
                              focusNode: focusNode,
                              maxLines: null,
                              style:  TextStyle(fontSize: 14.sp),
                              controller: _textMessageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: AppConst.typeAMessage,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () => selectVideo(messageReply),
                              child: const Icon(Icons.link)),
                           SizedBox(
                            width: 8.w,
                          ),
                          _textMessageController.text.isEmpty
                              ? InkWell(
                              onTap: () => selectImage(messageReply),
                              child: const Icon(Icons.camera_alt))
                              : const Text(""),
                        ],
                      ),
                       SizedBox(
                        width: 16.w,
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () {
                  _sendTextMessage(messageReply);
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  margin:  EdgeInsets.only(bottom: 8.h),
                  decoration:  BoxDecoration(
                    color: Palette.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(50.r),
                    ),
                  ),
                  child: Icon(
                    _textMessageController.text.isEmpty
                        ? isRecording
                        ? Icons.stop
                        : Icons.mic
                        : Icons.send,
                    color: Palette.textIconColor,
                  ),
                ),
              ),
            ],
          ),
          isShowEmojiContainer
              ? SizedBox(
            height: 310.h,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                setState(() {
                  _textMessageController.text =
                      _textMessageController.text + emoji.emoji;
                });
              },
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }

  Future<void> _sendTextMessage(MessageReply? messageReply) async {
    if (_textMessageController.text.isNotEmpty) {
      BlocProvider.of<CommunicationCubit>(context).sendTextMessage(
        recipientId: widget.singleCommunication.recipientUID,
        senderId: widget.singleCommunication.senderUID,
        recipientPhoneNumber: widget.singleCommunication.recipientPhoneNumber,
        recipientName: widget.singleCommunication.recipientName,
        senderPhoneNumber: widget.singleCommunication.senderPhoneNumber,
        senderName: widget.singleCommunication.senderName,
        message: _textMessageController.text,
        profileUrl: widget.singleCommunication.profileUrl,
        messageEnum: MessageEnum.text,
        isSeen: false,
        messageReply: messageReply,
      );
      _textMessageController.clear();
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}${AppConst.flutterSoundAcc}';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        di.sl<UploadImageToStorageUseCase>().call(File(path), "").then((value) {
          BlocProvider.of<CommunicationCubit>(context).sendImageMessage(
            senderName: widget.singleCommunication.senderName,
            senderId: widget.singleCommunication.senderUID,
            recipientId: widget.singleCommunication.recipientUID,
            recipientName: widget.singleCommunication.recipientName,
            message: value,
            recipientPhoneNumber: widget.singleCommunication.recipientPhoneNumber,
            senderPhoneNumber: widget.singleCommunication.senderPhoneNumber,
            messageEnum: MessageEnum.audio,
            profileUrl: widget.singleCommunication.profileUrl,
            isSeen: false,
            messageReply: messageReply,
          );
        });
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
    ref.read(messageReplyProvider.state).update((state) => null);
  }
}