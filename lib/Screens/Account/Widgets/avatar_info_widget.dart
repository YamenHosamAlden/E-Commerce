import 'dart:io';

import 'package:ecommerce/Bloc/profile_bloc/profile_bloc.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/avatarImage.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class AvatarInfoWidget extends StatelessWidget {
  final ProfileBloc profileBloc;
  final bool editButton;
  final File? fileImage;
  final bool myProfileScreen;
  final Function(File)? selectNewImage;
  const AvatarInfoWidget(
      {required this.profileBloc,
      super.key,
      this.editButton = false,
      this.myProfileScreen = true,
      this.fileImage,
      this.selectNewImage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileErrorState) {
          return MaterialButton(
            onPressed: () {
              profileBloc.add(GetProfileEvent());
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
          );
        }
        if (state is GetProfileLoadingState || state is ProfileInitial) {
          return Column(
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.greyColor.withOpacity(0.5),
                highlightColor: AppColors.greyColor,
                child: Container(
                  height: 15.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: AppColors.greyColor.withOpacity(0.5),
                highlightColor: AppColors.greyColor,
                child: Container(
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5.w)),
                ),
              ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                AvatarImage(
                  editButton: editButton,
                  stringImage: profileBloc.profileModel!.customer!.imageUrl,
                  fileImage: fileImage,
                  selectNewImage: selectNewImage,
                ),
                CustomText(
                  textData:
                      "${profileBloc.profileModel!.customer!.user!.firstName} ${profileBloc.profileModel!.customer!.user!.lastName}",
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
