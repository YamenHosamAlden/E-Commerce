import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/notification_model.dart';
import 'package:ecommerce/Data/Repository/notification_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository = NotificationRepository();
  NotificationModel? notificationModel;
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(GetNotificationsLoadingState());

      ApiResult apiResult = await notificationRepository.getNotifications();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        notificationModel =
            NotificationModel.fromJson(apiResult.response!.data);
        emit(GetNotificationsSuccessfulState());
      } else {
        emit(GetNotificationsErrorState(message: apiResult.error));
      }
    });

    on<SetSeenNotificationEvent>((event, emit) async {
      ApiResult apiResult = await notificationRepository.setSeentNotifications(
          ids: notificationModel!.ids!);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        for (int i = 0; i < notificationModel!.message!.length; i++) {
          notificationModel!.message![i].isSeen = true;
        }
        notificationModel!.ids!.clear();
        notificationModel!.isSeens!.clear();
        emit(GetNotificationsSuccessfulState());
      } else {
        emit(GetNotificationsErrorState(message: apiResult.error));
      }
    });
  }
}
