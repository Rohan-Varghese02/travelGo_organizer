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

class UploadPostSuccess extends ActionState {}

class UploadPostFailed extends ActionState {}

/// Edit Page --- Events

class NavigateToEditPage extends ActionState {
  final PostDataModel post;

  NavigateToEditPage({required this.post});
}

class EditTicketsUpdated extends ActionState {
  final List<Map<String, String>> tickets;

  EditTicketsUpdated(this.tickets);
}

class UpdatePostIntiateState extends ActionState {
  final PostDataModel post;

  UpdatePostIntiateState({required this.post});
}

class UpdatePostFailed extends ActionState {}

class UpdatePostSuccess extends ActionState {}

class UpdatePostFail extends ActionState {}

class DeletePostAlertBox extends ActionState {
  final PostDataModel post;

  DeletePostAlertBox({required this.post});
}

class DeletePostSuccess extends ActionState {}

class DeletePostFail extends ActionState {}

// Coupon
class CreateCouponSuccess extends ActionState {}

class CreateCouponFailed extends ActionState {}

class EditCouponSucess extends ActionState {}

class EditCouponFailed extends ActionState {}

class CouponStatusSuccess extends ActionState {}

class CouponStatusFailed extends ActionState {}

class CouponDeleteSuccess extends ActionState {}

class CouponDeleteFailed extends ActionState {}

// Request -- State
class CreateRequestSuccess extends ActionState {
  final String message;

  CreateRequestSuccess({required this.message});
}

class CreateRequestFailed extends ActionState {
  final String message;

  CreateRequestFailed({required this.message});
}

class EditRequestSucess extends ActionState {
  final String message;

  EditRequestSucess({required this.message});
}

class EditRequestFailed extends ActionState {
  final String message;

  EditRequestFailed({required this.message});
}

class RequestDeleteSuccess extends ActionState {
  final String message;

  RequestDeleteSuccess({required this.message});
}

class RequestDeleteFailed extends ActionState {
  final String message;

  RequestDeleteFailed({required this.message});
}

class CoverImageCleared extends ActionState {}

class BlogPhotoUploadSucess extends ActionState {
  final BlogData blogData;

  BlogPhotoUploadSucess({required this.blogData});
}

class BlogPhotoUploadError extends ActionState {}

class BlogUploadSuccess extends ActionState {}

class BlogUploadFailed extends ActionState {}

// My blogs---- State

class NavigateToEditBlog extends ActionState {
  final BlogData blogData;

  NavigateToEditBlog({required this.blogData});
}

class EditPartialDone extends ActionState {
  final BlogData editedBlog;

  EditPartialDone({required this.editedBlog});
}

class EditPartialFailed extends ActionState {
  final String message;

  EditPartialFailed({required this.message});
}

class EditBlogSuccessful extends ActionState {}

class EditBlogFailed extends ActionState {}

class DeleteBlogSuccess extends ActionState{}
class DeleteBlogFailed extends ActionState{}