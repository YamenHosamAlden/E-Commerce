import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/start_app_model.dart';
import 'package:ecommerce/Data/Repository/start_app_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'start_app_event.dart';
part 'start_app_state.dart';

class StartAppBloc extends Bloc<StartAppEvent, StartAppState> {
  StartAppRepository startAppRepository = StartAppRepository();
  StartAppModel? startAppModel;
  StartAppBloc() : super(StartAppInitial()) {
    on<StartAppEvent>((event, emit) async {
      emit(StartAppLoadingState());

      ApiResult apiResult = await startAppRepository.startApp();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        startAppModel = StartAppModel.fromJson(apiResult.response!.data);

        emit(StartAppSuccessfulState());
      } else {
        emit(StartAppErrorState(message: apiResult.error));
      }
    });
  }
}
