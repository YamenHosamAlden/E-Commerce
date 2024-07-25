import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/addrees_bloc/addrees_bloc.dart';
import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Screens/Account/Widgets/card_addrees_widget.dart';
import 'package:ecommerce/Screens/Account/select_location_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class DeliveryAddreesesScreen extends StatelessWidget {
  final bool cartScreen;
  final int? totalCost;
  DeliveryAddreesesScreen({this.totalCost, this.cartScreen = false, super.key});
  final AddreesBloc addreesBloc = AddreesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addreesBloc..add(GetAddreesEvent()),
      child: Scaffold(
        appBar: appBarWidget(context,
            title: cartScreen
                ? "Select addrees".tr(context)
                : "Delivery addresses".tr(context)),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            GeneralRoute.navigatorPushWithContext(
                context,
                SelectLocationScreen(
                  addreesBloc: addreesBloc,
                ));
          },
          label: Icon(
            Icons.add,
            color: Theme.of(context).textTheme.labelMedium!.color,
            size: 10.w,
          ),
        ),
        body: BlocConsumer<AddreesBloc, AddreesState>(
          listener: (context, state) {
            if (state is DeleteAddreesErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(errorSnackBar(context, message: state.message));
            }

            if (state is DeleteAddreesSuccessfulState) {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                  context,
                  message: "Addrees deleted".tr(context)));
            }
            if (state is ConfirmOrderSuccessfulState) {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                  context,
                  message: "The order has been confirmed".tr(context)));
              GeneralRoute.navigatorPobWithContext(context);
              BlocProvider.of<CartBloc>(context).add(GetCartListEvent());
            }
          },
          builder: (context, state) {
            if (state is GetAddreesesErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    addreesBloc.add(GetAddreesEvent());
                  });
            }
            if (state is GetAddreesesLoadingState || state is AddreesInitial) {
              return const LoadingWidget();
            }
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      addreesBloc.addreesModel!.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: addreesBloc.addreesModel!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: cartScreen
                                      ? () {
                                          addreesBloc.add(
                                              SelectAddreesEvent(index: index));
                                        }
                                      : null,
                                  child: CardAddreesWidget(
                                    addreesModel:
                                        addreesBloc.addreesModel![index],
                                    deleteFun: () {
                                      addreesBloc.add(DeleteAddreesEvent(
                                          addreesId: addreesBloc
                                              .addreesModel![index].id!,
                                          index: index));
                                    },
                                  ),
                                );
                              },
                            )
                          : EmptyWidget(
                              message: "There is no addreeses".tr(context)),
                      if (state is DeleteAddreesLoadingState)
                        Container(
                            alignment: Alignment.center,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            height: double.infinity,
                            width: double.infinity,
                            child: const LoadingWidget())
                    ],
                  ),
                ),
                if (cartScreen) ...[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: state is ConfirmOrderLoadingState
                        ? const LoadingWidget()
                        : CustomButton(
                            onPressed: () {
                              if (addreesBloc.addreesId != null) {
                                addreesBloc.add(ConfirmOrderEvent(
                                    totalCost: totalCost!,
                                    addreesId: addreesBloc.addreesId!));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    errorSnackBar(context,
                                        message:
                                            "You must choose a delivery address"
                                                .tr(context)));
                              }
                            },
                            buttonText: "Confirm Order".tr(context)),
                  )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
