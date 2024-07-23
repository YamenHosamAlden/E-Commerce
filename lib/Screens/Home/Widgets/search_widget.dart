import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Products/favorite_screen.dart';
import 'package:ecommerce/Screens/Search/search_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchWidget extends StatelessWidget {
  final bool homeScreen;
  final Function(String)? searchFun;

  SearchWidget({this.searchFun, this.homeScreen = false, super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5.w),
              bottomLeft: Radius.circular(5.w))),
      child: Row(
        children: [
          if (homeScreen)
            IconButton(
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, const FavoriteScreen());
              },
              icon: ImageIcon(
                const AssetImage(AppAssets.heartIcon),
                size: 8.w,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          Expanded(
              child: InkWell(
            onTap: () {
              GeneralRoute.navigatorPushWithContext(
                  context, const SearchScreen());
            },
            child: CustomTextField(
                enabled: !homeScreen,
                controller: searchController,
                hintText: "Search for anything you want".tr(context),
                prefixIcon: InkWell(
                  onTap: () {
                    searchFun!(searchController.text);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    child: Image(
                      image: const AssetImage(AppAssets.searchIcon),
                      color: Theme.of(context).primaryColor,
                      width: 5.w,
                      height: 2.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                textInputType: TextInputType.text),
          ))
        ],
      ),
    );
  }
}
