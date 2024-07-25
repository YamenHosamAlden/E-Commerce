import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/addrees_model.dart';
import 'package:ecommerce/Data/Repository/addrees_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'addrees_event.dart';
part 'addrees_state.dart';

class AddreesBloc extends Bloc<AddreesEvent, AddreesState> {
  List<AddreesModel>? addreesModel;
  AddreesRepository addreesRepository = AddreesRepository();
  int? addreesId;

  AddreesBloc() : super(AddreesInitial()) {
    on<GetAddreesEvent>((event, emit) async {
      emit(GetAddreesesLoadingState());
      ApiResult apiResult = await addreesRepository.getAddreeses();
      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        List<dynamic> res = apiResult.response!.data;

        addreesModel =
            res.map((addrees) => AddreesModel.fromJson(addrees)).toList();
        emit(GetAddreesesSuccessfulState());
      } else {
        emit(GetAddreesesErrorState(message: apiResult.error));
      }
    });

    on<SetNewAddreesEvent>((event, emit) async {
      emit(SetNewAddreesLoadingState());
      ApiResult apiResult = await addreesRepository.setNewAddress(
          addreesModel: event.addreesModel);
      if (apiResult.response != null && apiResult.response!.statusCode == 201) {
        emit(SetNewAddreesSuccessfulState());
      } else {
        emit(SetNewAddreesErrorState(message: apiResult.error));
      }
    });

    on<SelectAddreesEvent>((event, emit) async {
      for (int buttonIndex = 0;
          buttonIndex < addreesModel!.length;
          buttonIndex++) {
        if (event.index == buttonIndex) {
          addreesModel![buttonIndex].selected = true;
          addreesId = addreesModel![buttonIndex].id;
        } else {
          addreesModel![buttonIndex].selected = false;
        }
      }

      emit(GetAddreesesSuccessfulState());
    });

    on<DeleteAddreesEvent>((event, emit) async {
      emit(DeleteAddreesLoadingState());
      ApiResult apiResult =
          await addreesRepository.deleteAddrees(addreesId: event.addreesId);
      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        addreesModel!.removeAt(event.index);

        emit(DeleteAddreesSuccessfulState());
      } else {
        emit(DeleteAddreesErrorState(message: apiResult.error));
      }
    });

    on<ConfirmOrderEvent>((event, emit) async {
      emit(ConfirmOrderLoadingState());
      ApiResult apiResult = await addreesRepository.confirmOrder(
          totalCost: event.totalCost, addreesId: event.addreesId);
      if (apiResult.response != null && apiResult.response!.statusCode == 201) {
        emit(ConfirmOrderSuccessfulState());
      } else {
        emit(ConfirmOrderErrorState(message: apiResult.error));
      }
    });
  }
}
