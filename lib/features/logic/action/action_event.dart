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
