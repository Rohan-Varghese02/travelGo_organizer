import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/request_floating_btn.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/request_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RequestPage extends StatelessWidget {
  final OrganizerDataModel organizerData;

  const RequestPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is CreateRequestSuccess ||
              current is CreateRequestFailed ||
              current is EditRequestSucess ||
              current is EditRequestFailed ||
              current is RequestDeleteSuccess ||
              current is RequestDeleteFailed,
      listener: (context, state) {
        if (state is CreateRequestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: state.message, color: white),
              backgroundColor: success,
            ),
          );
        }
        if (state is EditRequestSucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: state.message, color: white),
              backgroundColor: success,
            ),
          );
        }
        if (state is RequestDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: state.message, color: white),
              backgroundColor: success,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Request for Featuring',
          color: themeColor,
          center: true,
        ),
        body: StreamBuilder(
          stream: StreamServices().getRequest(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return Center(
                child: StyleText(text: 'No request press + to add new'),
              );
            }
            final requests = snapshot.data;
            return ListView.builder(
              itemCount: requests!.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return RequestTile(request: request);
              },
            );
          },
        ),
        floatingActionButton: RequestFloatingBtn(organizerData: organizerData),
      ),
    );
  }
}
