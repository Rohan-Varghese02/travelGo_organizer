import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> updateOrganizerInFirestore(
    OrganizerUpdateModel organizer,
  ) async {
    await firestore
        .collection('Organizers')
        .doc(organizer.uid)
        .update(organizer.toMap());
  }

  Future<OrganizerDataModel> getOrganizer(String uid) async {
    final doc = await firestore.collection('Organizers').doc(uid).get();

    return OrganizerDataModel.fromMap(doc.data()!);
  }

  void reapplyOrganizer(String id) {
    firestore.collection('Organizers').doc(id).update({
      'role': 'pending-organizer',
    });
  }
}
