import 'package:flutter/material.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'network_image_model.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StackedView<NetworkImageModel> {
  const NetworkImageWidget({
    super.key,
    required this.url,
    required this.borderRadius,
    this.height,
    this.width,
  });

  final String url;
  final BorderRadiusGeometry borderRadius;
  final double? height, width;

  @override
  Widget builder(
      BuildContext context, NetworkImageModel viewModel, Widget? child) {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: url,
      height: height,
      width: width,
      errorListener: (value) => print(value),
      imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
      placeholder: (context, url) => MyShimmerEffectUI.rectangular(
          width: width ?? 335.w, height: height ?? 183.h),
      errorWidget: (context, url, error) => MyShimmerEffectUI.rectangular(
          width: width ?? 335.w, height: height ?? 183.h),
    );
  }

  @override
  NetworkImageModel viewModelBuilder(BuildContext context) =>
      NetworkImageModel();
}

class MyShimmerEffectUI extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const MyShimmerEffectUI.rectangular(
      {super.key, required this.width, required this.height})
      : shapeBorder = const RoundedRectangleBorder(side: BorderSide.none);

  const MyShimmerEffectUI.circular(
      {super.key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  const MyShimmerEffectUI.circularBorder(
      {super.key,
      required this.width,
      required this.height,
      required this.shapeBorder});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: kcDarkGreyColor,
        highlightColor: kcDarkGreyColor,
        period: const Duration(seconds: 3),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: kcGrayishPurple,
            shape: shapeBorder,
          ),
        ),
      );
}
