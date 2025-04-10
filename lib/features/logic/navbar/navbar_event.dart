part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class NavItemSelected extends NavbarEvent {
  final int index;

  NavItemSelected({required this.index});
}