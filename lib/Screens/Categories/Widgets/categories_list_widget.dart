import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  late List<bool> selectedList;
  @override
  void initState() {
    selectedList = [];
    super.initState();

    for (int i = 0; i < listCategoriesModel.length; i++) {
      if (i == 0) {
        selectedList.add(true);
      } else {
        selectedList.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCategoriesModel.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  for (int indexBtn = 0;
                      indexBtn < listCategoriesModel.length;
                      indexBtn++) {
                    if (indexBtn == index) {
                      selectedList[indexBtn] = true;
                    } else {
                      selectedList[indexBtn] = false;
                    }
                  }
                });
              },
              child: Row(
                children: [
                  selectedList[index]
                      ? IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            height: 4.h,
                            width: 1.w,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5.w)),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Container(
                      // width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      alignment: Alignment.center,
                      child: CustomText(
                        textData: listCategoriesModel[index].name,
                        textAlign: TextAlign.center,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).hintColor,
            )
          ],
        );
      },
    );
  }
}
