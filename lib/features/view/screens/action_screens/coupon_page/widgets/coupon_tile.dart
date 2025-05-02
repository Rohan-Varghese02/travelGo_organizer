import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/coupon_data.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/widgets/edit_copuon_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/text_fw.dart';

class CouponTile extends StatelessWidget {
  final CouponData coupon;
  final OrganizerDataModel organizerData;
  const CouponTile({
    super.key,
    required this.coupon,
    required this.organizerData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: themeColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFw(
                    fontSize: 20,
                    firstword: 'Code: ',
                    secondWord: coupon.codeName,
                  ),
                  TextFw(
                    fontSize: 18,
                    firstword: 'Discount: ',
                    secondWord: coupon.codeDiscount.toString(),
                  ),
                  TextFw(
                    fontSize: 13,
                    firstword: 'Post Name: ',
                    secondWord: coupon.postName,
                  ),
                  TextFw(
                    fontSize: 13,
                    firstword: 'Redeem: ',
                    secondWord: coupon.codeRedeem.toString(),
                  ),
                ],
              ),
              Column(
                children: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        editCouponCreationDialog(
                          context,
                          organizerData.uid,
                          coupon,
                        );
                      } else if (value == 'delete') {
                        context.read<ActionBloc>().add(
                          CouponDelete(couponUid: coupon.couponUid!),
                        );
                      }
                    },
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                    icon: Icon(Icons.more_vert),
                  ),
                  Switch(
                    value: coupon.isActive!,
                    onChanged: (value) {
                      context.read<ActionBloc>().add(
                        CouponStatus(
                          isActive: coupon.isActive!,
                          coupon: coupon,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
