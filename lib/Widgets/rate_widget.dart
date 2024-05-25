import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RateWidget extends StatelessWidget {
  final double numberOfStar;
  const RateWidget({required this.numberOfStar, super.key});

  @override
  Widget build(BuildContext context) {
    if (numberOfStar <= 0.5) {
      return rateHalfStar();
    }
    if (numberOfStar <= 1.0) {
      return rateOneStar();
    }
    if (numberOfStar <= 1.5) {
      return rateOneAndHalfStars();
    }
    if (numberOfStar <= 2.0) {
      return rateTwoStars();
    }
    if (numberOfStar <= 2.5) {
      return rateTwoAndHalfStars();
    }
    if (numberOfStar <= 3.0) {
      return rateThreeStars();
    }
    if (numberOfStar <= 3.5) {
      return rateThreeAndHalfStars();
    }
    if (numberOfStar <= 4.0) {
      return rateFourStars();
    }
    if (numberOfStar < 5.0) {
      return rateFourAndHalfStars();
    } else {
      return rateFiveStars();
    }
  }

  Widget rateFiveStars() {
    return Row(
      children: [
     
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateFourAndHalfStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_half,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateFourStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateThreeAndHalfStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_half,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateThreeStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateTwoAndHalfStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_half_sharp,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateTwoStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateOneAndHalfStars() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_half,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateOneStar() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateHalfStar() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_half,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }

  Widget rateZeroStar() {
    return Row(
      children: [
        

        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        ),
        Icon(
          Icons.star_border_outlined,
          color: Colors.amber,
          size: 5.w,
        )
      ],
    );
  }
}
