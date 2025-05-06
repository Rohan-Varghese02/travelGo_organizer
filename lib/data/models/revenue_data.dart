import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueModel {
  final String postId;
  final String postName;
  final String postImage;
  final int totalRevenue;
  final int totalTicketsSold;
  final Map<String, Map<String, int>> revenueByTicketType;
  final DateTime createdAt;

  RevenueModel({
    required this.postId,
    required this.postName,
    required this.postImage,
    required this.totalRevenue,
    required this.totalTicketsSold,
    required this.revenueByTicketType,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'postName': postName,
      'postImage': postImage,
      'totalRevenue': totalRevenue,
      'totalTicketsSold': totalTicketsSold,
      'revenueByTicketType': revenueByTicketType,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory RevenueModel.fromMap(Map<String, dynamic> map) {
    return RevenueModel(
      postId: map['postId'] ?? '',
      postName: map['postName'] ?? '',
      postImage: map['postImage'] ?? '',
      totalRevenue: map['totalRevenue'] ?? 0.toInt(),
      totalTicketsSold: map['totalTicketsSold'] ?? 0.toInt(),
      revenueByTicketType: Map<String, Map<String, int>>.from(
        (map['revenueByTicketType'] as Map).map((key, value) {
          return MapEntry(
            key,
            Map<String, int>.from(
              (value as Map).map(
                (k, v) => MapEntry(k.toString(), int.parse(v.toString())),
              ),
            ),
          );
        }),
      ),
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
    );
  }
}
