import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/navbar/navbar_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/chat_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/home_page/home_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/my_event_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/profile_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const MainScreen({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(),
      MyEventPage(),
      ChatPage(),
      ProfilePage(),
    ];
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.index, children: screens),
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
