import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/search_bloc/search_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SearchBarWidget extends StatefulWidget {
  final SearchBloc searchBloc;
  const SearchBarWidget({super.key, required this.searchBloc});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.searchBloc..add(CompletionSearchEvent()),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          margin: EdgeInsets.only(bottom: 1.h),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5.w),
                  bottomLeft: Radius.circular(5.w))),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return widget.searchBloc.completionModel!.message!
                      .where((String item) {
                    return item
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                displayStringForOption: (String option) => option,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return CustomTextField(
                    hintText: "Search for anything you want".tr(context),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        widget.searchBloc.add(SearchResultEvent(
                            result: textEditingController.text));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 2.h),
                          child: Image(
                            image: const AssetImage(AppAssets.searchIcon),
                            color: Theme.of(context).primaryColor,
                            width: 5.w,
                            height: 2.h,
                            fit: BoxFit.fill,
                          )),
                    ),
                    textInputType: TextInputType.text,
                    controller: textEditingController,
                    focusNode: focusNode,
                  );
                },
                onSelected: (option) {
                  widget.searchBloc.add(SearchResultEvent(result: option));
                },
                optionsMaxHeight: 15.h,
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Container(
                      height: 15.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(3.h)),
                      child: Column(
                        children: [
                          if (state is CompletionSearchErrorState) ...[
                            MaterialButton(
                              onPressed: () {
                                widget.searchBloc.add(CompletionSearchEvent());
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        state.message,
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                  Icon(
                                    Icons.restart_alt_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            )
                          ] else ...[
                            Expanded(
                              child: state is CompletionSearchLoadingState
                                  ? ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 3.w),
                                          child: Shimmer.fromColors(
                                            baseColor: AppColors.greyColor
                                                .withOpacity(0.5),
                                            highlightColor:
                                                AppColors.greyLightColor,
                                            child: Container(
                                              height: 3.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final String option =
                                            options.elementAt(index);
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          child: GestureDetector(
                                              onTap: () {
                                                onSelected(option);
                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomText(
                                                          textData: option,
                                                          textAlign:
                                                              TextAlign.start,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )
                                                ],
                                              )),
                                        );
                                      },
                                    ),
                            ),
                          ]
                        ],
                      ));
                },
              );
            },
          )),
    );
  }
}
