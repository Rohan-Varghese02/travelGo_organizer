part of 'action_bloc.dart';

@immutable
sealed class ActionState {}

// Create Event -- Events
class CoverImagePicked extends ActionState {
  final String imagePath;

  CoverImagePicked(this.imagePath);
}

class CoverImageError extends ActionState {
  final String message;
  CoverImageError(this.message);
}

final class ActionInitial extends ActionState {}

final class ActionError extends ActionState {
  final String message;

  ActionError({required this.message});
}

class TicketsUpdated extends ActionState {
  final List<Map<String, String>> tickets;

  TicketsUpdated({required this.tickets});
}

class CategoriesLoaded extends ActionState {
  final List<String> categories;
  final String? selectedCategory;

  CategoriesLoaded(this.categories, {this.selectedCategory});
}

class CountryLoaded extends ActionState {
  final List<String> countries;
  final String? selectedCountry;

  CountryLoaded(this.countries, {this.selectedCountry});
}

class CategoryChoosed extends ActionState {
  final String? selectedCategory;

  CategoryChoosed({required this.selectedCategory});
}

class CountryChoosed extends ActionState {
  final String? selectedCountry;

  CountryChoosed({required this.selectedCountry});
}

class NoCoverImage extends ActionState {}

class SuccessfullyUploadedPhoto extends ActionState {
  final String uid; 
  final String name;
  final String description;
  final String venue;
  final String country;
  final String imageUrl;
  final String imagePublicId;
  final Map<String, Map<String, int>> tickets;
  final String benefits;
  final String group;
  final String registrationDeadline;
  final double latitude;
  final double longitude;
  final String category;

  SuccessfullyUploadedPhoto({
    required this.uid,
    required this.name,
    required this.description,
    required this.venue,
    required this.country,
    required this.imageUrl,
    required this.imagePublicId,
    required this.tickets,
    required this.benefits,
    required this.group,
    required this.registrationDeadline,
    required this.latitude,
    required this.longitude,
    required this.category,
  });
}

class FailedUploadedPhoto extends ActionState {}

class UploadPostSuccess extends ActionState{}
class UploadPostFailed extends ActionState{}