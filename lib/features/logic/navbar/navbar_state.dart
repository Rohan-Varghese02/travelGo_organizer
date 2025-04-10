part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {
  final int index;

  NavbarState({required this.index});
}

final class NavbarInitial extends NavbarState {
  NavbarInitial() : super(index: 0);
}

class NavUpdated extends NavbarState {
  NavUpdated(int index) : super(index: index);
}