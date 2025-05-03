import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/coupon_dailog.dart';

class CouponFloatingBtn extends StatelessWidget {
  final String uid;
  const CouponFloatingBtn({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: themeColor,
      onPressed: () {
        showCouponCreationDialog(context, uid);
      },
      child: Icon(Icons.add, color: white),
    );
  }
}
