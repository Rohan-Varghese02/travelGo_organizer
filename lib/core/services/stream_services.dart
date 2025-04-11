import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

class StreamServices {
Stream<DocumentSnapshot<Map<String, dynamic>>> getOrganizerStream(String uid) {
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
}
