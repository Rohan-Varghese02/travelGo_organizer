import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/navbar/navbar_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
          ),
          child: GNav(
            gap: 5,
            activeColor: themeColor,
            color: grey99,
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.transparent,
            selectedIndex: state.index,
            onTabChange: (index) {
              context.read<NavbarBloc>().add(NavItemSelected(index: index));
            },
            tabs: [
              dotButton(FontAwesomeIcons.houseChimneyUser, 0, state.index),
              dotButton(FontAwesomeIcons.calendar, 1, state.index),
              dotButton(FontAwesomeIcons.message, 2, state.index),
              dotButton(FontAwesomeIcons.user, 3, state.index),
            ],
          ),
        );
      },
    );
  }
}

GButton dotButton(IconData icon, int index, int selectedIndex) {
  final isSelected = selectedIndex == index;

  return GButton(
    icon: icon,
    leading: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? themeColor : grey99),
        SizedBox(height: 4),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isSelected ? themeColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );
}
