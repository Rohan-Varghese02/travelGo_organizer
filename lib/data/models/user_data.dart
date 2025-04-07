class UserDataModel {
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

  UserDataModel({
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
}
