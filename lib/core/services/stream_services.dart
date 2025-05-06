import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/blog_data.dart';
import 'package:travelgo_organizer/data/models/coupon_data.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/data/models/request_data.dart';
import 'package:travelgo_organizer/data/models/revenue_data.dart';
import 'package:travelgo_organizer/data/models/userdata.dart';

class StreamServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    return firestore
        .collection('post')
        .where('uid', isEqualTo: uid)
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PostDataModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<CouponData>> getCoupons() {
    return firestore.collection('Coupons').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CouponData.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<RequestData>> getRequest() {
    return firestore.collection('Requests').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => RequestData.fromMap(doc.data()))
          .toList();
    });
  }

  Stream<List<BlogData>> getBlog() {
    return firestore.collection('Blogs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BlogData.fromMap(doc.data())).toList();
    });
  }

  Stream<List<RevenueModel>> getRevenue(String organizerID) {
    return firestore
        .collection('revenue')
        .doc(organizerID)
        .collection('posts')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => RevenueModel.fromMap(doc.data()))
              .toList();
        });
  }

  Stream<List<Userdata>> getClients(String postID) {
    return firestore
        .collection('post')
        .doc(postID)
        .collection('users')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Userdata.fromMap(doc.data()))
              .toList();
        });
  }
}
