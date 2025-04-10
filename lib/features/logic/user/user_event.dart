part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserProfileEdit extends UserEvent {
  final OrganizerDataModel organizerData;

  UserProfileEdit({required this.organizerData});
}

class UpdateImageEvent extends UserEvent {}

class ProfileUpdatIntiate extends UserEvent{}

class UpdateProfileEvent extends UserEvent {
  final String imagePublicID;
  final String imageUrl;
  final String uid;
  final String? imagePath;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String designation;
  final String about;
  final String experience;

  UpdateProfileEvent({
    required this.imagePublicID,
    required this.imageUrl,
    required this.uid,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.designation,
    required this.about,
    required this.experience,
  });

}
  class FetchDetails extends UserEvent{}
