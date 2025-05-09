import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/message_data.dart';

class ChatServices {
  //Send message
  Future<void> sendMessage(
    String recieverID,
    String message,
    currentUserUid,
    currentUsermail,
  ) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // get current user info
    final String currentUserID = currentUserUid;
    final String currentEmail = currentUsermail;
    final Timestamp timestamp = Timestamp.now();

    List<String> id = [currentUserID, recieverID];
    id.sort(); // this is to have same id for both receiver and sender
    String chatRoomID = id.join('_');

    // add new message to database
    // firebaseFirestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomID)
    //     .collection('message')
    //     .add(newMessage.toMap());
    final docId =
        firebaseFirestore
            .collection('chat_rooms')
            .doc(chatRoomID)
            .collection('message')
            .doc();
    //create new message
    MessageData newMessage = MessageData(
      senderID: currentUserID,
      senderEmail: currentEmail,
      recieverID: recieverID,
      message: message,
      timestamp: timestamp,
      uid: docId.id,
    );
    docId.set(newMessage.toMap());

    // construct chat room ID for two users (Sorted to ensure uniqueness)
  }

  Stream<List<MessageData>> getMessage(String userID, String recieverID) {
    List<String> id = [userID, recieverID];
    id.sort();
    String chatRoomID = id.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageData.fromFirestore(doc.data()))
              .toList();
        });
  }

  Future<void> updateMessageandTime(
    String message,
    Timestamp time,
    String oranizerUid,
    userId,
  ) async {
    return FirebaseFirestore.instance
        .collection('UserChatrooms')
        .doc(oranizerUid)
        .collection('Users')
        .doc(userId)
        .update({
          'lastMessage': message,
          'lastMessageTime': Timestamp.now(),
          'lastMessagebool': true,
        });
  }

  Future<void> updateSeen(Timestamp time, String oranizerUid, userId) async {
    return FirebaseFirestore.instance
        .collection('UserChatrooms')
        .doc(oranizerUid)
        .collection('Users')
        .doc(userId)
        .update({'lastMessagebool': true});
  }

  Future<void> updateMessageandTimeOrganizer(
    String message,
    Timestamp time,
    String organizerUid,
    userUid,
  ) {
    return FirebaseFirestore.instance
        .collection('OrganizerChatrooms')
        .doc(userUid)
        .collection('Organizers')
        .doc(organizerUid)
        .update({
          'lastMessage': message,
          'lastMessageTime': Timestamp.now(),
          'lastMessageBool': false,
        });
  }
}
