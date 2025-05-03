import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/coupon_dailog.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/coupon_floating_btn.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/coupon_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class CouponPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const CouponPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is CreateCouponSuccess ||
              current is CreateCouponFailed ||
              current is EditCouponSucess ||
              current is EditCouponFailed ||
              current is CouponDeleteSuccess,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is CreateCouponSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(
                text: 'Coupon Created Successfully',
                color: white,
              ),
              backgroundColor: success,
            ),
          );
        }
        if (state is EditCouponSucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: 'Edit Coupon Successful', color: white),
              backgroundColor: success,
            ),
          );
        }
        if (state is CouponDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(
                text: 'Coupon Deleted Successfully',
                color: white,
              ),
              backgroundColor: success,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Create Coupon',
          color: themeColor,
          center: true,
        ),
        body: StreamBuilder(
          stream: StreamServices().getCoupons(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return Center(
                child: Center(
                  child: StyleText(
                    text: 'No Coupons added press + to add Coupon',
                  ),
                ),
              );
            }
            final coupons = snapshot.data;
            return ListView.builder(
              itemCount: coupons!.length,
              itemBuilder: (context, index) {
                final coupon = coupons[index];
                return CouponTile(coupon: coupon, organizerData: organizerData);
              },
            );
          },
        ),
        floatingActionButton: CouponFloatingBtn(uid: organizerData.uid),
      ),
    );
  }
}
