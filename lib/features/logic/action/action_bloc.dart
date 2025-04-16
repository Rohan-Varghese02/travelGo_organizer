import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
    final ImagePicker _picker = ImagePicker();
  ActionBloc() : super(ActionInitial()) {
    // Create Event --- Events
    on<PickCoverImageEvent>(pickCoverImageEvent);
  }

  // Create Event --- Events

  FutureOr<void> pickCoverImageEvent(PickCoverImageEvent event, Emitter<ActionState> emit) async{
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
}
