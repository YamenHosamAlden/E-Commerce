import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/notification_bloc/notification_bloc.dart';
import 'package:ecommerce/Screens/Notification/Widgets/notification_card_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationBloc notificationBloc;
  @override
  void initState() {
    super.initState();
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    if (notificationBloc.notificationModel!.isSeens!.isNotEmpty) {
      notificationBloc.add(SetSeenNotificationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, title: "Notification".tr(context)),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is GetNotificationsLoadingState ||
              state is NotificationInitial) {
            return const LoadingWidget();
          }
          if (state is GetNotificationsErrorState) {
            return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  notificationBloc.add(GetNotificationsEvent());
                });
          }
          return ListView.builder(
            itemCount: notificationBloc.notificationModel!.message!.length,
            itemBuilder: (context, index) {
              return NotificationCardWidget(
                notification:
                    notificationBloc.notificationModel!.message![index],
              );
            },
          );
        },
      ),
    );
  }
}
