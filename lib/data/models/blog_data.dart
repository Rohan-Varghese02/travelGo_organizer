class BlogData {
  final String imageUrl;
  final String imageID;
  final String blogDetails;
  final String organizerUID;
  String? blogID;

  BlogData({
    required this.imageUrl,
    required this.imageID,
    required this.blogDetails,
    required this.organizerUID,
    this.blogID,
  });
  Map<String, String> toMap() {
    return {
      'imageUrl': imageUrl,
      'imageID': imageID,
      'blogDetails': blogDetails,
      'organizerUID': organizerUID,
      'blogID': blogID!,
    };
  }

  factory BlogData.fromMap(Map<String, dynamic> map) {
    return BlogData(
      imageUrl: map['imageUrl'] ?? '',
      imageID: map['imageID'],
      blogDetails: map['blogDetails'],
      organizerUID: map['organizerUID'],
      blogID: map['blogID'] ?? 'no value',
    );
  }
}
