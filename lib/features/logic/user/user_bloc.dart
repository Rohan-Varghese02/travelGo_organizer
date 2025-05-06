import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_organizer/core/services/api_services.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/core/services/firestore_service.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // Profile Page ------- Edit Logic
    on<FetchDetails>(fetchDetails);
    on<UserProfileEdit>(userProfileEdit);
    on<UpdateImageEvent>(updateImageEvent);
    on<ProfileUpdatIntiate>(profileUpdatIntiate);
    on<UpdateProfileEvent>(updateProfileEvent);

    // Dashboard (Home Page Actions)
    on<CreateEventClicked>(createEventClicked);
    on<CouponEventClicked>(couponEventClicked);
    on<RequestEventClicked>(requestEventClicked);
    on<CreateBlogClicked>(createBlogClicked);
    on<MyBlogClicked>(myBlogClicked);
    on<AnalyticsClicked>(analyticsClicked);
  }

  // Profile Page ------- Edit Logic

  FutureOr<void> fetchDetails(
    FetchDetails event,
    Emitter<UserState> emit,
  ) async {
    final auth = Authservice();
    final firestore = FirestoreService();
    String uid = auth.getUserUid();
    log(uid);
    OrganizerDataModel organizerData = await firestore.getOrganizer(uid);
    emit(ProfileDetailsFetched(organizerData: organizerData));
  }

  FutureOr<void> userProfileEdit(
    UserProfileEdit event,
    Emitter<UserState> emit,
  ) {
    log('Navigation trigger');
    emit(NavigateToEditPage(organizerData: event.organizerData));
  }

  FutureOr<void> updateImageEvent(
    UpdateImageEvent event,
    Emitter<UserState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(ProfileImageUpdatedSucess(imagePath: pickedFile.path));
      } else {
        emit(ProfileImageUpdateFailed(message: 'No image selected'));
      }
    } catch (e) {
      emit(ProfileImageUpdateFailed(message: "Error picking Image: $e"));
    }
  }

  FutureOr<void> updateProfileEvent(
    UpdateProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    final api = ApiServices();
    String imagePublicID = event.imagePublicID;
    String imageUrl = event.imageUrl;

    try {
      if (event.imagePath != null) {
        if (event.imagePublicID.isNotEmpty) {
          final deleted = await api.deleteImageFromCloudinary(
            event.imagePublicID,
          );
          if (!deleted) {
            log("Failed to delete old image.");
          }
        }
        Map<String, String> url = await api.getUploadUrl(event.imagePath!);
        imageUrl = url['imageUrl']!;
        imagePublicID = url['publicId']!;
      }
      OrganizerUpdateModel organizer = OrganizerUpdateModel(
        company: event.company,
        designation: event.designation,
        about: event.about,
        experience: event.experience,
        name: event.name,
        uid: event.uid,
        email: event.email,
        phoneNumber: event.phone,
        imageUrl: imageUrl,
        imagePublicID: imagePublicID,
      );
      final firestore = FirestoreService();
      await firestore.updateOrganizerInFirestore(organizer);
      emit(ProfileUpdateSuccess());
      OrganizerDataModel organizerData = await firestore.getOrganizer(
        event.uid,
      );
      emit(ProfileDetailsFetched(organizerData: organizerData));
    } catch (e) {
      log(e.toString());
      emit(ProfileImageUpdateFailed(message: 'Some error'));
    }
  }

  FutureOr<void> profileUpdatIntiate(
    ProfileUpdatIntiate event,
    Emitter<UserState> emit,
  ) {
    emit(UserProfileIntiated());
  }

  FutureOr<void> createEventClicked(
    CreateEventClicked event,
    Emitter<UserState> emit,
  ) {
    log('Create Event Intitate');
    emit(CreateEventIntitated());
  }

  FutureOr<void> couponEventClicked(
    CouponEventClicked event,
    Emitter<UserState> emit,
  ) {
    emit(CouponEventIntiated(organizerData: event.organizerData));
  }

  FutureOr<void> requestEventClicked(
    RequestEventClicked event,
    Emitter<UserState> emit,
  ) {
    emit(RequestEventIntiated(organizerData: event.organizerData));
  }

  FutureOr<void> createBlogClicked(
    CreateBlogClicked event,
    Emitter<UserState> emit,
  ) {
    emit(CreateBlogNavigateIntiate(organizerData: event.organizerData));
  }

  FutureOr<void> myBlogClicked(MyBlogClicked event, Emitter<UserState> emit) {
    emit(MyBlogNavigateIntiate(organizerData: event.organizerData));
  }

  FutureOr<void> analyticsClicked(
    AnalyticsClicked event,
    Emitter<UserState> emit,
  ) {
    emit(AnalyticsNavigateIntiate(organizerData: event.organizerData));
  }
}
