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

  UploadCoverPhoto({required this.uid, required this.name, required this.description, required this.venue, required this.imagePath, required this.country, required this.tickets, required this.benefits, required this.group, required this.registrationDeadline, required this.latitude, required this.longitude, required this.category});
}

class UploadPostEvent extends ActionEvent{
    final PostDataModel post;

  UploadPostEvent({required this.post});


}