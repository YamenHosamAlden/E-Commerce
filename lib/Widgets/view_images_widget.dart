import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';

class ViewImagesWidget extends StatelessWidget {
  final List<String>? images;
  final String? image;
  final int? activeIndex;

  const ViewImagesWidget(
      {super.key, this.activeIndex, this.image, this.images});

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: images != null ? activeIndex! : 0);
    return Scaffold(
      body: Stack(
        children: [
          images != null
              ? PhotoViewGallery.builder(
                  itemCount: images!.length,
                  pageController: pageController,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(images![index]));
                  },
                )
              : PhotoViewGallery(
                  pageOptions: [
                    PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(image!))
                  ],
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Card(
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          child: Icon(
                            Icons.arrow_back,
                            size: 25.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
