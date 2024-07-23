import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/filter_bloc/filter_bloc.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

selectFilterBottomSheet(BuildContext context,
    {required String slug,
    required Function(List<int>?, List<int>?, String?, String?) filterSelect}) {
  FilterBloc filterBloc = FilterBloc();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();

  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.w), topRight: Radius.circular(8.w))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => filterBloc..add(FilterEvent(slug: slug)),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 60.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                  child: Divider(
                    thickness: 4,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(child: BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    if (state is GetFiltersErrorState) {
                      return ErrorMessageWidget(
                          message: state.message,
                          onPressed: () {
                            filterBloc.add(FilterEvent(slug: slug));
                          });
                    }
                    if (state is FilterInitial ||
                        state is GetFiltersLoadingState) {
                      return const LoadingWidget();
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    tilePadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    childrenPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    title: CustomText(
                                      textData: "Brand".tr(context),
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filterBloc
                                            .filterModel!.brands!.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            value: filterBloc.filterModel!
                                                .brands![index].select,
                                            onChanged: (bool? value) {
                                              filterBloc.add(
                                                  SelectCheckBoxBrandEvent(
                                                      value: value!,
                                                      index: index,
                                                      brandId: filterBloc
                                                          .filterModel!
                                                          .brands![index]
                                                          .id!));
                                            },
                                            title: CustomText(
                                              textData: filterBloc.filterModel!
                                                  .brands![index].name,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          );
                                        },
                                      ),
                                    ]),
                              ),
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    tilePadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    childrenPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    title: CustomText(
                                      textData: "Size".tr(context),
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filterBloc
                                            .filterModel!.sizes!.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            value: filterBloc.filterModel!
                                                .sizes![index].select,
                                            onChanged: (bool? value) {
                                              filterBloc.add(
                                                  SelectCheckBoxSizeEvent(
                                                      value: value!,
                                                      index: index,
                                                      sizeId: filterBloc
                                                          .filterModel!
                                                          .sizes![index]
                                                          .id!));
                                            },
                                            title: CustomText(
                                              textData: filterBloc.filterModel!
                                                  .sizes![index].value,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          );
                                        },
                                      ),
                                    ]),
                              ),
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                    tilePadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    childrenPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    title: CustomText(
                                      textData: "Price".tr(context),
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller: minPriceController,
                                              textInputType:
                                                  TextInputType.number,
                                              hintText: "Min Price".tr(context),
                                              onChanged: (text) {
                                                filterBloc.minPrice = text;
                                              },
                                              validator: (input) {
                                                if (input!.isEmpty) {
                                                  return "This field is required"
                                                      .tr(context);
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 8.w,
                                          ),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: maxPriceController,
                                              textInputType:
                                                  TextInputType.datetime,
                                              hintText: "Max Price".tr(context),
                                              onChanged: (text) {
                                                filterBloc.maxPrice = text;
                                              },
                                              validator: (input) {
                                                if (input!.isEmpty) {
                                                  return "This field is required"
                                                      .tr(context);
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CustomButton(
                                onPressed: () {
                                  filterBloc.add(ClearFilterEvent());
                                  minPriceController.clear();
                                  maxPriceController.clear();
                                },
                                buttonText: "Clear".tr(context),
                              )),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    filterSelect(
                                        filterBloc.sizeIds,
                                        filterBloc.brandIds,
                                        filterBloc.minPrice,
                                        filterBloc.maxPrice);
                                    GeneralRoute.navigatorPobWithContext(
                                        context);
                                  },
                                  buttonText: "Save".tr(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      );
    },
  );
}
