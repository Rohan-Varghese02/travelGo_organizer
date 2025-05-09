import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  final String userUid;
  final String userImage;
  final String userName;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool lastMessagebool;
  ChatData({
    required this.lastMessagebool,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.userUid,
    required this.userImage,
    required this.userName,
    req,
  });
  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'userImage': userImage,
      'userName': userName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessagebool': lastMessagebool,
    };
  }

  factory ChatData.fromFirestore(Map<String, dynamic> doc) {
    return ChatData(
      userUid: doc['userUid'] ?? '',
      userImage: doc['userImage'] ?? '',
      userName: doc['userName'] ?? '',
      lastMessage: doc['lastMessage'],
      lastMessageTime: doc['lastMessageTime'],
      lastMessagebool: doc['lastMessagebool'],
    );
  }
}
