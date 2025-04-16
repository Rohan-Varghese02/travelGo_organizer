part of 'action_bloc.dart';

@immutable
sealed class ActionEvent {}

// Create Event -- Events
class PickCoverImageEvent extends ActionEvent {}

class CoverImagePicked extends ActionState {
  final String imagePath;

  CoverImagePicked(this.imagePath);
}
class CoverImageError extends ActionState {
  final String message;
  CoverImageError(this.message);
}