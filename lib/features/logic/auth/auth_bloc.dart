import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_organizer/core/services/api_services.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/core/services/local_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ImagePicker _picker = ImagePicker();
  AuthBloc() : super(AuthInitial()) {
    on<IntialSplashEvent>(intialSplashEvent);
    on<GetStartedNavigationEvent>(getStartedNavigationEvent);
    on<VisibillityButtonClicked>(visibillityButtonClicked);
    on<CheckLoginEvent>(checkLoginEvent);
    on<LogOutButtonClicked>(logOutButtonClicked);
    on<JoinButtonClicked>(joinButtonClicked);
    on<AlreadyMemeber>(alreadyMemeber);
    on<GoogleSignInEvent>(googleSignIn);

    on<RegisterButtonEvent>(registerButtonEvent);
    //////////////////////
    ///
    ///
    on<PickImageEvent>(pickImageEvent);
    on<UploadImageEvent>(uploadImageEvent);
    on<RegisterUser>(registerUser);

    on<NoImageEvent>(noImageEvent);
  }

  FutureOr<void> intialSplashEvent(
    IntialSplashEvent event,
    Emitter<AuthState> emit,
  ) async {
    bool isFirst = await LocalStorage.isFirstLaunch();
    if (isFirst) {
      LocalStorage.setFirstLaunch();
      emit(FirstTimeLoading());
    } else {
      emit(OnceLoadedState());
    }
  }

  FutureOr<void> getStartedNavigationEvent(
    GetStartedNavigationEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(LoginPageNavigationState());
  }

  FutureOr<void> visibillityButtonClicked(
    VisibillityButtonClicked event,
    Emitter<AuthState> emit,
  ) {
    bool isVisible = event.isVisible;
    isVisible = !isVisible;
    emit(VisibleState(isVisible: isVisible));
  }

  FutureOr<void> checkLoginEvent(
    CheckLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final auth = Authservice();
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(LoginSuccessState(userCredential: user));
    } catch (e) {
      emit(LoginFailedState(error: e.toString()));
    }
  }

  FutureOr<void> logOutButtonClicked(
    LogOutButtonClicked event,
    Emitter<AuthState> emit,
  ) async {
    final auth = Authservice();
    await auth.signOut();
    emit(LogoutState());
  }

  FutureOr<void> joinButtonClicked(
    JoinButtonClicked event,
    Emitter<AuthState> emit,
  ) {
    emit(NavigateToRegister());
  }

  FutureOr<void> googleSignIn(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final auth = Authservice();
      final UserCredential userCredential = await auth.signInWithGoogle();

      if (userCredential.user != null) {
        emit(GoogleLoginSucess(userCredential: userCredential));
      } else {
        emit(GoogleLoginFailure(error: "Google Sign-In failed"));
      }
    } catch (e) {
      emit(GoogleLoginFailure(error: e.toString()));
    }
  }

  /// Register Screen Events

  FutureOr<void> alreadyMemeber(AlreadyMemeber event, Emitter<AuthState> emit) {
    emit(ReturnToLogin());
  }

  FutureOr<void> registerButtonEvent(
    RegisterButtonEvent event,
    Emitter<AuthState> emit,
  ) {
    if (event.password != event.confirmPassword) {
      emit(PasswordConfirmedPassDifferent());
    } else {
      emit(ContinueRegisteration(email: event.email, password: event.password));
    }
  }

  //Register Screen Events

  FutureOr<void> pickImageEvent(
    PickImageEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(ProfileImagePicked(pickedFile.path));
      } else {
        emit(ProfileError("No image selected"));
      }
    } catch (e) {
      emit(ProfileError("Error picking image: $e"));
    }
  }

  FutureOr<void> uploadImageEvent(
    UploadImageEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ProfileImageUploading());
    final apiservices = ApiServices();
    String imageUrl = await apiservices.getUploadUrl(event.imagePath);
    emit(ProfileImageUploaded(imageUrl));
  }

  FutureOr<void> registerUser(
    RegisterUser event,
    Emitter<AuthState> emit,
  ) async {
    final authservices = Authservice();
    try {
      await authservices.signUpWithEmailAndPassword(
        event.name,
        event.email,
        event.password,
        'user',
        event.phoneNumber,
        event.imageUrl,
        event.nameOfCompany,
        event.designation,
        event.about,
        event.experience,
      );
      emit(RegisterSuccessful());
    } catch (e) {
      log(e.toString());
      emit(RegisterationError());
    }
  }

  FutureOr<void> noImageEvent(NoImageEvent event, Emitter<AuthState> emit) {
    emit(NoImageState());
  }
}
