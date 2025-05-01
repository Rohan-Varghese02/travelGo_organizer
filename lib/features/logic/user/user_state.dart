part of 'user_bloc.dart';

@immutable
sealed class UserState {}

sealed class UserActionState extends UserState {}

final class UserInitial extends UserState {}

class OrganizerSuccessfullyFetched extends UserState {
  final OrganizerDataModel organizerDataModel;

  OrganizerSuccessfullyFetched({required this.organizerDataModel});
}
// Profile Page ------- Edit Logic

class NavigateToEditPage extends UserState {
  final OrganizerDataModel organizerData;

  NavigateToEditPage({required this.organizerData});
}

class ProfileImageUpdatedSucess extends UserState {
  final String imagePath;

  ProfileImageUpdatedSucess({required this.imagePath});
}

class ProfileImageUpdateFailed extends UserState {
  final String message;

  ProfileImageUpdateFailed({required this.message});
}

class UserProfileIntiated extends UserState {}

class ProfileUpdateSuccess extends UserState {}

class ProfileUpdateFailed extends UserState {}

class ProfileDetailsFetched extends UserActionState {
  final OrganizerDataModel organizerData;
  ProfileDetailsFetched({required this.organizerData});
}

// Dashboard (Home Page Actions)

class CreateEventIntitated extends UserState {}

class CouponEventIntiated extends UserState{
    final OrganizerDataModel organizerData;

  CouponEventIntiated({required this.organizerData});

}