import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/filter_model.dart';
import 'package:ecommerce/Data/Repository/product_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:flutter/material.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvents, FilterState> {
  ProductRepository productRepository = ProductRepository();
  FilterModel? filterModel;
  List<int> sizeIds = [];
  List<int> brandIds = [];
  String? minPrice;
  String? maxPrice;

  void deselectAll() {
    for (var size in filterModel!.sizes!) {
      if (size.select == true) {
        size.select = false;
      }
    }

    for (var size in filterModel!.brands!) {
      if (size.select == true) {
        size.select = false;
      }
    }
  }

  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) async {
      emit(GetFiltersLoadingState());

      ApiResult apiResult =
          await productRepository.getFilters(slug: event.slug);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        filterModel = FilterModel.fromJson(apiResult.response!.data);

        emit(GetFiltersSuccessfulState());
      } else {
        emit(GetFiltersErrorState(message: apiResult.error));
      }
    });

    on<SelectCheckBoxSizeEvent>((event, emit) async {
      filterModel!.sizes![event.index].select = event.value;
      sizeIds.add(event.sizeId);

      emit(GetFiltersSuccessfulState());
    });
    on<SelectCheckBoxBrandEvent>((event, emit) async {
      filterModel!.brands![event.index].select = event.value;
      brandIds.add(event.brandId);
      emit(GetFiltersSuccessfulState());
    });

    on<ClearFilterEvent>((event, emit) async {
      deselectAll();
      sizeIds.clear();
      brandIds.clear();
      minPrice = null;
      maxPrice = null;

      emit(GetFiltersSuccessfulState());
    });
  }
}
