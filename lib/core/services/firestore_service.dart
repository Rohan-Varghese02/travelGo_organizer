import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

class FirestoreService {
  Future<void> updateOrganizerInFirestore(
    OrganizerUpdateModel organizer,
  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Organizers')
        .doc(organizer.uid)
        .update(organizer.toMap());
  }

  Future<OrganizerDataModel> getOrganizer(String uid) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('Organizers')
            .doc(uid)
            .get();

    return OrganizerDataModel.fromMap(doc.data()!);
  }
}
