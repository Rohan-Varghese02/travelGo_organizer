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
  int? followersCount;

  OrganizerDataModel({
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
  });
  Map<String, dynamic> toMap() {
    return {
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
    };
  }

  factory OrganizerDataModel.fromMap(Map<String, dynamic> map) {
    return OrganizerDataModel(
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
    );
  }
}
