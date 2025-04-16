part of 'action_bloc.dart';

@immutable
sealed class ActionState {}

// Create Event -- Events

final class ActionInitial extends ActionState {}
