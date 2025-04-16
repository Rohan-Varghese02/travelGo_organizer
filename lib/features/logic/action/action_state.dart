part of 'action_bloc.dart';

@immutable
sealed class ActionState {}

// Create Event -- Events

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
