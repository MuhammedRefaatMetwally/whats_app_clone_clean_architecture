import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/data/model/single_communication_model.dart';
import '../../domain/entities/text_message_entity.dart';

class ChatBodyModel{
  final List<TextMessageEntity> messages;
  final ScrollController scrollController;
  final String senderUid;
  final SingleCommunication? singleCommunication;

  ChatBodyModel(
      {required this.messages,
      required this.scrollController,
      required this.senderUid,
       this.singleCommunication});
}