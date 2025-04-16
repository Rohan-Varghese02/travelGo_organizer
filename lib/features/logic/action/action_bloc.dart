import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  final ImagePicker _picker = ImagePicker();
  ActionBloc() : super(ActionInitial()) {
    // Create Event --- Events
    on<PickCoverImageEvent>(pickCoverImageEvent);
    on<AddTicket>(addTicket);
    on<RemoveTicket>(removeTicket);
    on<UpdateTicketType>(updateTicketType);
    on<UpdateTicketCount>(updateTicketCount);
    on<LoadCategories>(loadCategories);
    on<CategorySelected>(categorySelected);
    on<LoadCountries>(loadCountries);
    on<CountrySelected>(countrySelected);
  }

  // Create Event --- Events

  FutureOr<void> pickCoverImageEvent(
    PickCoverImageEvent event,
    Emitter<ActionState> emit,
  ) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(CoverImagePicked(pickedFile.path));
      } else {
        emit(CoverImageError("No image selected"));
      }
    } catch (e) {
      emit(CoverImageError("Error picking image: $e"));
    }
  }
  // --- Ticket Logic ---

  FutureOr<void> addTicket(AddTicket event, Emitter<ActionState> emit) {
    final state = this.state;

    if (state is TicketsUpdated) {
      final updatedTickets = List<Map<String, String>>.from(state.tickets)
        ..add({"type": "", "count": ""}); // Adding a new empty ticket
      emit(TicketsUpdated(tickets: updatedTickets));
    } else {
      emit(
        TicketsUpdated(
          tickets: [
            {"type": "", "count": ""},
          ],
        ),
      );
    }
  }

  FutureOr<void> removeTicket(RemoveTicket event, Emitter<ActionState> emit) {
    final state = this.state;

    if (state is TicketsUpdated) {
      final updatedTickets = List<Map<String, String>>.from(state.tickets)
        ..removeAt(event.index); // Removing the ticket by index
      emit(TicketsUpdated(tickets: updatedTickets));
    }
  }

  FutureOr<void> updateTicketType(
    UpdateTicketType event,
    Emitter<ActionState> emit,
  ) {
    final state = this.state;

    if (state is TicketsUpdated) {
      final updatedTickets = List<Map<String, String>>.from(state.tickets);
      updatedTickets[event.index]["type"] = event.value; // Updating ticket type
      emit(TicketsUpdated(tickets: updatedTickets));
    }
  }

  FutureOr<void> updateTicketCount(
    UpdateTicketCount event,
    Emitter<ActionState> emit,
  ) {
    final state = this.state;

    if (state is TicketsUpdated) {
      final updatedTickets = List<Map<String, String>>.from(state.tickets);
      updatedTickets[event.index]["count"] =
          event.value; // Updating ticket count
      emit(TicketsUpdated(tickets: updatedTickets));
    }
  }

  FutureOr<void> loadCategories(
    LoadCategories event,
    Emitter<ActionState> emit,
  ) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('categories')
              .where('type', isEqualTo: 'event')
              .get();

      final categoryList =
          snapshot.docs.map((doc) => doc['name'].toString()).toList();
      emit(CategoriesLoaded(categoryList));
    } catch (e) {
      emit(ActionInitial()); // Or emit an error state
    }
  }

  FutureOr<void> categorySelected(
    CategorySelected event,
    Emitter<ActionState> emit,
  ) {
    if (state is CategoriesLoaded) {
      final current = (state as CategoriesLoaded);
      emit(
        CategoriesLoaded(
          current.categories,
          selectedCategory: event.selectedCategory,
        ),
      );
    }
  }

  FutureOr<void> loadCountries(
    LoadCountries event,
    Emitter<ActionState> emit,
  ) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('categories')
              .where('type', isEqualTo: 'country')
              .get();

      final countryList =
          snapshot.docs.map((doc) => doc['name'].toString()).toList();
      emit(CountryLoaded(countryList));
    } catch (e) {
      emit(ActionInitial()); // Or emit an error state
    }
  }

  FutureOr<void> countrySelected(
    CountrySelected event,
    Emitter<ActionState> emit,
  ) {
    if (state is CountryLoaded) {
      final current = (state as CountryLoaded);
      emit(
        CountryLoaded(
          current.countries,
          selectedCountry: event.selectedCountry,
        ),
      );
    }
  }
}
