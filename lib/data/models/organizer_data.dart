import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizerDataModel {
  final String name;
  final String uid;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final String imageUrl;
  final String company;
  final String designation;
  final String about;
  final String experience;
  final String imagePublicId;
  int? followersCount;
  int? eventHosted;

  OrganizerDataModel({
    required this.imagePublicId,
    required this.company,
    required this.designation,
    required this.about,
    required this.experience,
    required this.name,
    required this.uid,
    required this.email,
    required this.password,
    this.role = 'pending-organizer',
    required this.phoneNumber,
    required this.imageUrl,
    required this.followersCount,
    required this.eventHosted,
  });
  Map<String, dynamic> toMap() {
    return {
      "imagePublicID": imagePublicId,
      "name": name,
      "uid": uid,
      "email": email,
      "password": password,
      "role": role,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "company": company,
      "designation": designation,
      "about": about,
      "experience": experience,
      "followers": 0,
      "eventHosted": 0,
    };
  }

  factory OrganizerDataModel.fromMap(Map<String, dynamic> map) {
    return OrganizerDataModel(
      imagePublicId: map['imagePublicID'],
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      company: map['company'] ?? '',
      designation: map['designation'] ?? '',
      about: map['about'] ?? '',
      experience: map['experience'] ?? '',
      followersCount: map['followers'],
      eventHosted: map['eventHosted'],
    );
  }
  factory OrganizerDataModel.fromFireStore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return OrganizerDataModel.fromMap(map);
  }
}

class OrganizerUpdateModel {
  final String imagePublicID;
  final String name;
  final String uid;
  final String email;
  final String phoneNumber;
  final String imageUrl;
  final String company;
  final String designation;
  final String about;
  final String experience;
  OrganizerUpdateModel({
    required this.imagePublicID,
    required this.company,
    required this.designation,
    required this.about,
    required this.experience,
    required this.name,
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      "imagePublicID": imagePublicID,
      "name": name,
      "uid": uid,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "company": company,
      "designation": designation,
      "about": about,
      "experience": experience,
    };
  }

  factory OrganizerUpdateModel.fromMap(Map<String, dynamic> map) {
    return OrganizerUpdateModel(
      imagePublicID: map['imagePublicID'],
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      company: map['company'] ?? '',
      designation: map['designation'] ?? '',
      about: map['about'] ?? '',
      experience: map['experience'] ?? '',
    );
  }
}
