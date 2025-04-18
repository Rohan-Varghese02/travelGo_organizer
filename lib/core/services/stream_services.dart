import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';

class StreamServices {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getOrganizerStream(
    String uid,
  ) {
    return FirebaseFirestore.instance
        .collection('Organizers')
        .doc(uid)
        .snapshots();
  }

  Stream<OrganizerDataModel> getOrganizerByUid(String uid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection('Organizers')
        .doc(uid)
        .snapshots()
        .map((doc) => OrganizerDataModel.fromFireStore(doc));
  }

  Stream<List<PostDataModel>> getPostsByOrganizer(String uid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return firestore
        .collection('posts')
        .doc(uid)
        .collection('posts')
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PostDataModel.fromMap(doc.data());
          }).toList();
        });
  }
}
