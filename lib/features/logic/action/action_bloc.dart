import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_organizer/core/services/api_services.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';

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
    on<UpdateTicketPrice>(updateTicketPrice);

    on<LoadCategories>(loadCategories);
    on<CategorySelected>(categorySelected);
    on<LoadCountries>(loadCountries);
    on<CountrySelected>(countrySelected);
    on<CoverImageNotFound>(coverImageNotFound);
    on<UploadCoverPhoto>(uploadCoverPhoto);
    on<UploadPostEvent>(uploadPostToFirestore);

    // Edit Event --- Events
    on<EditButtonPressed>(editButtonPressed);
    on<UpdateTicketList>(updateTicketList);

    /// check working ??
    List<Map<String, String>> editTickets = [];

    on<LoadEditTickets>((event, emit) {
      editTickets = List.from(event.tickets);
      emit(EditTicketsUpdated(editTickets));
    });

    on<AddEditTicket>((event, emit) {
      editTickets.add({"type": "", "price": "", "count": ""});
      emit(EditTicketsUpdated(List.from(editTickets)));
    });

    on<UpdateEditTicketType>((event, emit) {
      editTickets[event.index]["type"] = event.value;
      emit(EditTicketsUpdated(List.from(editTickets)));
    });

    on<UpdateEditTicketPrice>((event, emit) {
      editTickets[event.index]["price"] = event.value;
      emit(EditTicketsUpdated(List.from(editTickets)));
    });

    on<UpdateEditTicketCount>((event, emit) {
      editTickets[event.index]["count"] = event.value;
      emit(EditTicketsUpdated(List.from(editTickets)));
    });

    on<RemoveEditTicket>((event, emit) {
      editTickets.removeAt(event.index);
      emit(EditTicketsUpdated(List.from(editTickets)));
    });

    on<UpdateCoverPhotoEvent>(updateCoverPhotoEvent);
    on<UpdatePostIntiated>(updatePostIntiated);

    //Delete Event --- MyEvents
    on<DeletePostEvent>(deletePostEvent);
    on<DeletePostIntiated>(deletePostIntiated);
  }

  // Create Event --- Events

  FutureOr<void> pickCoverImageEvent(
    PickCoverImageEvent event,
    Emitter<ActionState> emit,
  ) async {
    log('Image to be picked');
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
      final updatedTickets = List<Map<String, String>>.from(state.tickets);
      updatedTickets.add({"type": "", "price": "", "count": ""});
      emit(TicketsUpdated(tickets: updatedTickets));
    } else {
      emit(
        TicketsUpdated(
          tickets: [
            {"type": "", "price": "", "count": ""},
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

  FutureOr<void> updateTicketPrice(
    UpdateTicketPrice event,
    Emitter<ActionState> emit,
  ) {
    final state = this.state;

    if (state is TicketsUpdated) {
      final updatedTickets = List<Map<String, String>>.from(state.tickets);
      updatedTickets[event.index]["price"] =
          event.value; // Updating ticket price
      emit(TicketsUpdated(tickets: updatedTickets));
    }
  }

  FutureOr<void> loadCategories(
    LoadCategories event,
    Emitter<ActionState> emit,
  ) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .where('type', isEqualTo: 'event')
            .get();

    final categoryList =
        snapshot.docs.map((doc) => doc['name'].toString()).toList();
    emit(CategoriesLoaded(categoryList));
  }

  FutureOr<void> categorySelected(
    CategorySelected event,
    Emitter<ActionState> emit,
  ) {
    log('Selected category');
    log(event.selectedCategory);
    emit(CategoryChoosed(selectedCategory: event.selectedCategory));
  }

  FutureOr<void> loadCountries(
    LoadCountries event,
    Emitter<ActionState> emit,
  ) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .where('type', isEqualTo: 'country')
            .get();

    final countryList =
        snapshot.docs.map((doc) => doc['name'].toString()).toList();
    emit(CountryLoaded(countryList));
  }

  FutureOr<void> countrySelected(
    CountrySelected event,
    Emitter<ActionState> emit,
  ) {
    emit(CountryChoosed(selectedCountry: event.selectedCountry));
  }

  FutureOr<void> coverImageNotFound(
    CoverImageNotFound event,
    Emitter<ActionState> emit,
  ) {
    emit(NoCoverImage());
  }

  FutureOr<void> uploadCoverPhoto(
    UploadCoverPhoto event,
    Emitter<ActionState> emit,
  ) async {
    final apiservices = ApiServices();
    Map<String, String> urls = await apiservices.getUploadUrl(event.imagePath);
    String? imageUrl = urls['imageUrl'];
    String? imagePublicID = urls['publicId'];
    emit(
      SuccessfullyUploadedPhoto(
        uid: event.uid,
        name: event.name,
        description: event.description,
        venue: event.venue,
        country: event.country,
        imageUrl: imageUrl!,
        imagePublicId: imagePublicID!,
        tickets: event.tickets,
        benefits: event.benefits,
        group: event.group,
        registrationDeadline: event.registrationDeadline,
        latitude: event.latitude,
        longitude: event.longitude,
        category: event.category,
      ),
    );
  }

  FutureOr<void> uploadPostToFirestore(
    UploadPostEvent event,
    Emitter<ActionState> emit,
  ) async {
    try {
      final post = event.post;

      final postRef =
          FirebaseFirestore.instance
              .collection('posts')
              .doc(post.uid)
              .collection('posts')
              .doc();
      post.postId = postRef.id;
      await postRef.set(post.toMap());

      log("Post uploaded: ${postRef.id}");
      emit(UploadPostSuccess());
    } catch (e) {
      log("Error uploading post: $e");
      emit(UploadPostFailed());
    }
  }

  FutureOr<void> editButtonPressed(
    EditButtonPressed event,
    Emitter<ActionState> emit,
  ) {
    emit(NavigateToEditPage(post: event.post));
  }

  FutureOr<void> updateTicketList(
    UpdateTicketList event,
    Emitter<ActionState> emit,
  ) {
    emit(TicketsUpdated(tickets: event.tickets));
  }

  FutureOr<void> updateCoverPhotoEvent(
    UpdateCoverPhotoEvent event,
    Emitter<ActionState> emit,
  ) async {
    final api = ApiServices();
    String imagePublicId = event.imagePublicId;
    String imageUrl = event.imageUrl;

    try {
      log(event.imagePath);
      if (event.imagePath != 'default') {
        if (event.imagePublicId.isNotEmpty) {
          final deleted = await api.deleteImageFromCloudinary(
            event.imagePublicId,
          );
          if (!deleted) {
            log("Failed to delete old image.");
          }
        }
        Map<String, String> url = await api.getUploadUrl(event.imagePath);
        imageUrl = url['imageUrl']!;
        imagePublicId = url['publicId']!;
      }
      PostDataModel post = PostDataModel(
        timestamp: event.post.timestamp,
        uid: event.uid,
        name: event.name,
        description: event.description,
        venue: event.venue,
        country: event.country,
        imageUrl: imageUrl,
        imagePublicId: imagePublicId,
        tickets: event.tickets,
        benefits: event.benefits,
        group: event.group,
        registrationDeadline: event.registrationDeadline,
        latitude: event.latitude,
        longitude: event.longitude,
        category: event.category,
        postId: event.post.postId,
      );
      emit(UpdatePostIntiateState(post: post));
    } catch (e) {
      emit(UpdatePostFailed());
    }
  }

  FutureOr<void> updatePostIntiated(
    UpdatePostIntiated event,
    Emitter<ActionState> emit,
  ) async {
    try {
      final post = event.post;

      final postRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(post.uid)
          .collection('posts')
          .doc(post.postId);

      await postRef.update(post.toMap());

      log("Post updted: ${postRef.id}");
      emit(UpdatePostSuccess());
    } catch (e) {
      log("Error uploading post: $e");
      emit(UpdatePostFail());
    }
  }

  FutureOr<void> deletePostEvent(
    DeletePostEvent event,
    Emitter<ActionState> emit,
  ) {
    emit(DeletePostAlertBox(post: event.post));
  }

  FutureOr<void> deletePostIntiated(
    DeletePostIntiated event,
    Emitter<ActionState> emit,
  ) async {
    final post = event.post;
    final api = ApiServices();
    final deleted = await api.deleteImageFromCloudinary(post.imagePublicId);
    if (!deleted) {
      log("Failed to delete old image.");
    }
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.uid)
          .collection('posts')
          .doc(post.postId)
          .delete();
      log("Post deleted successfully");
      emit(DeletePostSuccess());
    } catch (e) {
      log("Error deleting post: $e");
      emit(DeletePostFail());
    }
  }
}
