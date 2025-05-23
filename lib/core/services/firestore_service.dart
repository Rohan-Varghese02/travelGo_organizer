import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_organizer/data/models/blog_data.dart';
import 'package:travelgo_organizer/data/models/coupon_data.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/data/models/request_data.dart';

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

  Future<void> uploadCoupon(CouponData coupon) async {
    final doc = firestore.collection('Coupons').doc();
    final docId = doc.id;
    await doc.set(coupon.toMap(docId));
  }

  Future<void> updateCoupon(CouponData coupon) async {
    await firestore
        .collection('Coupons')
        .doc(coupon.couponUid)
        .update(coupon.toMap(coupon.couponUid));
  }

  Future<void> updateCouponStatus(CouponData coupon, bool isActive) async {
    await firestore.collection('Coupons').doc(coupon.couponUid).update({
      'isActive': isActive,
    });
  }

  Future<void> deleteCoupon(String couponUid) async {
    await firestore.collection('Coupons').doc(couponUid).delete();
  }

  Future<void> createRequest(RequestData request) async {
    final doc = firestore.collection('Requests').doc();
    String docId = doc.id;
    doc.set(request.toMap(docId));
  }

  Future<void> editRequest(RequestData request) async {
    await firestore
        .collection('Requests')
        .doc(request.requestId)
        .update(request.toMap(request.requestId!));
  }

  Future<void> deleteRequest(String requestUid) async {
    await firestore.collection('Requests').doc(requestUid).delete();
  }

  Future<void> uploadBlog(BlogData blogData) async {
    final docID = firestore.collection('Blogs').doc();
    blogData.blogID = docID.id;
    docID.set(blogData.toMap());
  }

  Future<void> editUploadBlog(BlogData blogdata, String blogID) async {
    await firestore
        .collection('Blogs')
        .doc(blogdata.blogID)
        .update(blogdata.toMap());
  }

  Future<void> deleteBlog(String blogId) async {
    await firestore.collection('Blogs').doc(blogId).delete();
  }

  Future<void> initializeRevenueData({
    required String organizerUid,
    required String postId,
    required String postName,
    required String postImage,
    required Map<String, Map<String, int>> ticketMap,
  }) async {
    final revenueRef = FirebaseFirestore.instance
        .collection('revenue')
        .doc(organizerUid)
        .collection('posts')
        .doc(postId);

    final revenueByTicketType = {
      for (var type in ticketMap.keys) type: {'revenue': 0, 'soldCount': 0},
    };

    final revenueData = {
      'postId': postId,
      'postName': postName,
      'postImage': postImage,
      'totalRevenue': 0,
      'totalTicketsSold': 0,
      'revenueByTicketType': revenueByTicketType,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await revenueRef.set(revenueData);
  }
}
