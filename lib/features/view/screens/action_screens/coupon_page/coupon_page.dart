
import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/coupon_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';

class CouponPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const CouponPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Coupon',
        color: themeColor,
        center: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCouponCreationDialog(context, organizerData.uid);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
