import 'package:cloud_firestore/cloud_firestore.dart';

class BlogData {
  final String imageUrl;
  final String imageID;
  final String blogDetails;
  final String organizerUID;
  final String organizerImage;
  final DateTime? date;
  String? blogID;

  BlogData({
    required this.imageUrl,
    required this.imageID,
    required this.blogDetails,
    required this.organizerUID,
    required this.organizerImage,
    this.blogID,
    this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'organizerImage': organizerImage,
      'imageUrl': imageUrl,
      'imageID': imageID,
      'blogDetails': blogDetails,
      'organizerUID': organizerUID,
      'blogID': blogID!,
      'date': DateTime.now(),
    };
  }

  factory BlogData.fromMap(Map<String, dynamic> map) {
    return BlogData(
      organizerImage: map['organizerImage'],
      imageUrl: map['imageUrl'] ?? '',
      imageID: map['imageID'],
      blogDetails: map['blogDetails'],
      organizerUID: map['organizerUID'],
      blogID: map['blogID'] ?? 'no value',
      date:
          map['date'] != null
              ? (map['date'] is Timestamp
                  ? (map['date'] as Timestamp).toDate()
                  : DateTime.tryParse(map['date'].toString()))
              : null,
    );
  }
}
