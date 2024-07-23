import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/addrees_bloc/addrees_bloc.dart';
import 'package:ecommerce/Data/Models/addrees_model.dart';
import 'package:ecommerce/Screens/Account/Widgets/google_map_widget.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class SelectLocationScreen extends StatefulWidget {
  final AddreesBloc addreesBloc;
  const SelectLocationScreen({required this.addreesBloc, super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController subAdministrativeAreaController =
      TextEditingController();
  TextEditingController subLocalityController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addreesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  LatLng? latLng;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.addreesBloc,
      child: Scaffold(
        appBar: appBarWidget(context, title: "Add Location".tr(context)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GoogleMapWidget(
                  selectAddress: (
                      {latLng,
                      postalCode,
                      street,
                      country,
                      subAdministrativeArea,
                      subLocality}) {
                    countryController.text = country!;
                    postalCodeController.text = postalCode!;
                    streetController.text = street!;
                    subAdministrativeAreaController.text =
                        subAdministrativeArea!;
                    subLocalityController.text = subLocality!;
                    this.latLng = latLng;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: countryController,
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    labelText: "Country".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: subAdministrativeAreaController,
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    labelText: "City".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: subLocalityController,
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    labelText: "Sub Locality".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: streetController,
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    labelText: "Street".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: addreesController,
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    labelText: "Addrees name".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: phoneController,
                    textInputType: TextInputType.number,
                    maxLine: 1,
                    labelText: "Phone".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: CustomTextField(
                    controller: detailsController,
                    textInputType: TextInputType.text,
                    maxLine: 2,
                    labelText: "Details".tr(context),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "This field is required".tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                BlocConsumer<AddreesBloc, AddreesState>(
                  listener: (context, state) {
                    if (state is SetNewAddreesErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar(context, message: state.message));
                    }

                    if (state is SetNewAddreesSuccessfulState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          successSnackBar(context,
                              message:
                                  "A new address has been added".tr(context)));
                      widget.addreesBloc.add(GetAddreesEvent());
                      GeneralRoute.navigatorPobWithContext(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is SetNewAddreesLoadingState) {
                      return const LoadingWidget();
                    }
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AddreesModel addreesModel = AddreesModel(
                                      addressName: addreesController.text,
                                      district: subLocalityController.text,
                                      city:
                                          subAdministrativeAreaController.text,
                                      details:
                                          "${streetController.text} | ${detailsController.text}",
                                      latitude: latLng!.latitude,
                                      longitude: latLng!.longitude,
                                      phoneNumber: phoneController.text);
                                  widget.addreesBloc.add(SetNewAddreesEvent(
                                      addreesModel: addreesModel));
                                }
                              },
                              buttonText: "Add".tr(context)),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
