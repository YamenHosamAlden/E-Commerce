import 'package:country_picker/country_picker.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomCountryPickerWidget extends StatefulWidget {
  final void Function(Country) onSelect;
  final TextEditingController textEditingController;
  final Country? country;

  final String hintText;
  final String hintSearchText;
  final String? Function(String?)? validator;
  const CustomCountryPickerWidget(
      {super.key,
      required this.onSelect,
      required this.textEditingController,
      this.country,
      required this.hintText,
      this.validator,
      required this.hintSearchText});
  @override
  State<CustomCountryPickerWidget> createState() =>
      _CustomCountryPickerWidgetState();
}

class _CustomCountryPickerWidgetState extends State<CustomCountryPickerWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.country != null) {
      country = widget.country;
    }
  }

  Country? country;

  pickCountry() {
    showCountryPicker(
      context: context,

      countryListTheme: CountryListThemeData(
        backgroundColor: Theme.of(context).primaryColor,
        textStyle: Theme.of(context).textTheme.displayMedium,

        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          topRight: Radius.circular(5.w),
        ),
        //Optional. Styles the search field.

        inputDecoration: InputDecoration(
          filled: true,
          isDense: true,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          hintText: widget.hintSearchText,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).hintColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.greyLightColor, width: 1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.greyLightColor, width: 1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide:
                  const BorderSide(color: AppColors.greyLightColor, width: 1)),
        ),
      ),
      // customFlagBuilder: (country) {
      //   return CustomText(
      //     textData: country.e164Key,
      //   );
      // },

      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          this.country = country;
          widget.onSelect(country);
        });
        // BlocProvider.of<ProfileBloc>(context).nationalityController.text =
        //     country.displayNameNoCountryCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: CustomTextField(
        controller: widget.textEditingController,
        prefixIcon: GestureDetector(
          onTap: () {
            pickCountry();
          },
          child: Container(
              width: 15.w,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              decoration: BoxDecoration(
                  border: Border(
                left: AppSharedPreferences.hasArLang
                    ? BorderSide(color: Theme.of(context).primaryColor)
                    : BorderSide.none,
                right: !AppSharedPreferences.hasArLang
                    ? BorderSide(color: Theme.of(context).primaryColor)
                    : BorderSide.none,
              )),
              child: CustomText(
                textData: AppSharedPreferences.hasArLang
                    ? "${country?.phoneCode ?? 963}+"
                    : "+${country?.phoneCode ?? 963}",
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              )),
        ),
        validator: widget.validator,
        textInputType: TextInputType.phone,
        hintText: widget.hintText,
      ),
    );
  }
}
