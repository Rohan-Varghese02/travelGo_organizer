part of 'action_bloc.dart';

@immutable
sealed class ActionEvent {}

// Create Event -- Events
class PickCoverImageEvent extends ActionEvent {}

////
///
/// Event to add a new ticket
class AddTicket extends ActionEvent {}

class RemoveTicket extends ActionEvent {
  final int index;
  RemoveTicket(this.index);
}

class UpdateTicketType extends ActionEvent {
  final int index;
  final String value;
  UpdateTicketType(this.index, this.value);
}

class UpdateTicketPrice extends ActionEvent {
  final int index;
  final String value;
  UpdateTicketPrice(this.index, this.value);
}

class UpdateTicketCount extends ActionEvent {
  final int index;
  final String value;
  UpdateTicketCount(this.index, this.value);
}

class LoadCategories extends ActionEvent {}

class CategorySelected extends ActionEvent {
  final String selectedCategory;
  CategorySelected(this.selectedCategory);
}

class LoadCountries extends ActionEvent {}

class CountrySelected extends ActionEvent {
  final String selectedCountry;

  CountrySelected({required this.selectedCountry});
}

class CoverImageNotFound extends ActionEvent {}

// ignore: must_be_immutable
class UploadCoverPhoto extends ActionEvent {
  final String uid;
  final String name;
  final String description;
  final String venue;
  final String imagePath;
  final String country;
  Map<String, Map<String, int>> tickets;
  final String benefits;
  final String group;
  final String registrationDeadline;
  final double latitude;
  final double longitude;
  final String category;

  UploadCoverPhoto({
    required this.uid,
    required this.name,
    required this.description,
    required this.venue,
    required this.imagePath,
    required this.country,
    required this.tickets,
    required this.benefits,
    required this.group,
    required this.registrationDeadline,
    required this.latitude,
    required this.longitude,
    required this.category,
  });
}

class UploadPostEvent extends ActionEvent {
  final PostDataModel post;

  UploadPostEvent({required this.post});
}

/// Edit Page --- Events

class EditButtonPressed extends ActionEvent {
  final PostDataModel post;

  EditButtonPressed({required this.post});
}

class UpdateTicketList extends ActionEvent {
  final List<Map<String, String>> tickets;
  UpdateTicketList(this.tickets);
}

// EDIT EVENT TICKETS
class LoadEditTickets extends ActionEvent {
  final List<Map<String, String>> tickets;

  LoadEditTickets(this.tickets);
}

class AddEditTicket extends ActionEvent {}

class UpdateEditTicketType extends ActionEvent {
  final int index;
  final String value;

  UpdateEditTicketType(this.index, this.value);
}

class UpdateEditTicketPrice extends ActionEvent {
  final int index;
  final String value;

  UpdateEditTicketPrice(this.index, this.value);
}

class UpdateEditTicketCount extends ActionEvent {
  final int index;
  final String value;

  UpdateEditTicketCount(this.index, this.value);
}

class RemoveEditTicket extends ActionEvent {
  final int index;

  RemoveEditTicket(this.index);
}

class UpdateCoverPhotoEvent extends ActionEvent {
  final PostDataModel post;
  final String uid;
  final String name;
  final String description;
  final String venue;
  final String imagePath;
  final String country;
  final Map<String, Map<String, int>> tickets;
  final String benefits;
  final String group;
  final String registrationDeadline;
  final double latitude;
  final double longitude;
  final String category;
  final String imageUrl;
  final String imagePublicId;

  UpdateCoverPhotoEvent({
    required this.post,
    required this.uid,
    required this.name,
    required this.description,
    required this.venue,
    required this.imagePath,
    required this.country,
    required this.tickets,
    required this.benefits,
    required this.group,
    required this.registrationDeadline,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.imageUrl,
    required this.imagePublicId,
  });
}

class UpdatePostIntiated extends ActionEvent {
  final PostDataModel post;

  UpdatePostIntiated({required this.post});
}

class DeletePostEvent extends ActionEvent {
  final PostDataModel post;

  DeletePostEvent({required this.post});
}

class DeletePostIntiated extends ActionEvent {
  final PostDataModel post;

  DeletePostIntiated({required this.post});
}

/// Coupon - Events
class CreateCoupon extends ActionEvent {
  final CouponData coupon;

  CreateCoupon({required this.coupon});
}

class EditCoupon extends ActionEvent {
  final CouponData coupon;

  EditCoupon({required this.coupon});
}

class CouponStatus extends ActionEvent {
  final CouponData coupon;
  final bool isActive;

  CouponStatus({required this.isActive, required this.coupon});
}

class CouponDelete extends ActionEvent {
  final String couponUid;

  CouponDelete({required this.couponUid});
}

// Request -- Events
class CreateRequest extends ActionEvent {
  final RequestData request;

  CreateRequest({required this.request});
}

class EditRequest extends ActionEvent {
  final RequestData request;

  EditRequest({required this.request});
}

class RequestDelete extends ActionEvent {
  final String requestId;

  RequestDelete({required this.requestId});
}

class ClearCoverImage extends ActionEvent {}

class UploadBlogPhoto extends ActionEvent {
  final String imagePath;
  final String postDetails;
  final String organizerUID;
  final String organizerImage;

  UploadBlogPhoto({
    required this.imagePath,
    required this.postDetails,
    required this.organizerUID,
    required this.organizerImage,
  });
}

class UploadBlog extends ActionEvent {
  final BlogData blogData;

  UploadBlog({required this.blogData});
}
// ---- My Blogs --- events

class EditBlogButton extends ActionEvent {
  final BlogData blogData;

  EditBlogButton({required this.blogData});
}

class EditBlog extends ActionEvent {
  final String? imagePath;
  final BlogData blogdata;

  EditBlog({required this.imagePath, required this.blogdata});
}

class UploadEditBlog extends ActionEvent {
  final BlogData editedBlogData;

  UploadEditBlog({required this.editedBlogData});
}

class DeleteBlog extends ActionEvent {
  final BlogData blogData;

  DeleteBlog({required this.blogData});
}
