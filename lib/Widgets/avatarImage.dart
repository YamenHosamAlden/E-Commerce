import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/view_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class AvatarImage extends StatefulWidget {
  final Function(File)? selectNewImage;
  final File? fileImage;
  final String? stringImage;
  final bool editButton;

  const AvatarImage(
      {this.stringImage,
      this.fileImage,
      super.key,
      this.selectNewImage,
      this.editButton = true});

  @override
  State<AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  String? selctedImage;
  String? currantImage;

  @override
  void initState() {
    super.initState();

    currantImage = widget.stringImage;

    if (widget.fileImage != null) {
      selctedImage = widget.fileImage!.path;
    }
  }

  Widget imageTypeWidget() {
    if (currantImage != null) {
      return CachedNetworkImage(
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.greyColor.withOpacity(0.5),
          highlightColor: AppColors.greyLightColor,
          child: Container(
            height: 15.h,
            width: 30.w,
            decoration:  BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        imageBuilder: (context, imageProvider) => InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            GeneralRoute.navigatorPushWithContext(
              type: PageTransitionType.fade,
              context,
              ViewImagesWidget(
                image: currantImage,
              ),
            );
          },
          child: Container(
              height: 15.h,
              width: 30.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover))),
        ),
        fadeInDuration: const Duration(milliseconds: 4),
        fadeOutDuration: const Duration(milliseconds: 4),
        imageUrl: currantImage!,
        errorWidget: (context, url, error) => Container(
          height: 15.h,
          width: 30.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child:  Image(
            image:const  AssetImage(AppAssets.profileCircleImage),
            color: Theme.of(context).primaryColor,
            fit: BoxFit.cover,
          ),
        ),
        fit: BoxFit.cover,
      );
    }
    if (selctedImage != null) {
      return Container(
          height: 15.h,
          width: 30.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: FileImage(File(
                    selctedImage!,
                  )),
                  fit: BoxFit.cover)));
    } else {
      return Container(
        height: 15.h,
        width: 30.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child:  Image(
          image:const  AssetImage(AppAssets.profileCircleImage),
          color:  Theme.of(context).primaryColor,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        imageTypeWidget(),
        if (widget.editButton)
          GestureDetector(
            onTap: () {
              showImageDialog(context);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 3.h, right: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.w),
                      bottomRight: Radius.circular(2.w),
                      topRight: Radius.circular(2.w))),
              child: Image.asset(
                AppAssets.editIcon,
                height: 2.h,
              ),
            ),
          )
      ],
    );
  }

  Future showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(
                textData: "Choose the image".tr(context),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 20.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 25.w,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    "Gallery".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    size: 25.w,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    "Camera".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  // photoSelect(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       barrierColor: Colors.transparent,
  //       backgroundColor: Colors.transparent,
  //       builder: (context) {
  //         return PickImage(onImagePicked: (imagePath) {
  //           widget.function(File(imagePath));
  //           setState(() {
  //             selctedImage = imagePath;
  //           });
  //         });
  //       });
  // }
}
