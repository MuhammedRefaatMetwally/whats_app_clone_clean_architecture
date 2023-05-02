class SingleCommunication{
  final String senderUID;
  final String recipientUID;
  final String senderName;
  final String recipientName;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;
  final String profileUrl;
  final bool isGroupChat;

  SingleCommunication(
      {required this.isGroupChat,
      required this.senderUID,
      required this.recipientUID,
      required this.senderName,
      required this.recipientName,
      required this.recipientPhoneNumber,
      required this.senderPhoneNumber,
      required this.profileUrl});

}