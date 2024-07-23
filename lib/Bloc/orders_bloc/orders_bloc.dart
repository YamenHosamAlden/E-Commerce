import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/orders_model.dart';
import 'package:ecommerce/Data/Repository/orders_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersRepository ordersRepository = OrdersRepository();
  OrdersListModel? ordersListModel;
  OrderDetailsModel? orderDetailsModel;
  OrdersBloc() : super(OrdersInitial()) {
    on<GetAllOrdersEvent>((event, emit) async {
      emit(GetAllOrdersLoadingState());

      ApiResult apiResult = await ordersRepository.getAllOrders();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        ordersListModel = OrdersListModel.fromJson(apiResult.response!.data);
        emit(GetAllOrdersSuccessfulState());
      } else {
        emit(GetAllOrdersErrorState(message: apiResult.error));
      }
    });

    on<GetOrderEvent>((event, emit) async {
      emit(GetOrderLoadingState());

      ApiResult apiResult =
          await ordersRepository.getOrder(orderId: event.orderId);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        orderDetailsModel =
            OrderDetailsModel.fromJson(apiResult.response!.data);
        emit(GetOrderSuccessfulState());
      } else {
        emit(GetOrderErrorState(message: apiResult.error));
      }
    });
  }
}
