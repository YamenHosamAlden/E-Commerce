import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/completion_model.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Data/Repository/product_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ProductRepository productRepository = ProductRepository();
  ProductList? productList;
  CompletionModel? completionModel;
  SearchBloc() : super(SearchInitial()) {
    on<SearchResultEvent>((event, emit) async {
      emit(SearchResultLoadingState());

      ApiResult apiResult =
          await productRepository.searchResult(result: event.result);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);
        emit(SearchResultSuccessfulState());
      } else {
        emit(SearchResultErrorState(message: apiResult.error));
      }
    });

    on<CompletionSearchEvent>((event, emit) async {
      emit(CompletionSearchLoadingState());
      ApiResult apiResult = await productRepository.completionSearch(
      );
      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        completionModel = CompletionModel.fromJson(apiResult.response!.data);
        emit(CompletionSearchSuccessfulState());
      } else {
        emit(CompletionSearchErrorState(message: apiResult.error));
      }
    });
  }
}
