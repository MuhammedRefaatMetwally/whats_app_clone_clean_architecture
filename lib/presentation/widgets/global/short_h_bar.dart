import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';


class ShortHBar extends StatelessWidget {
  const ShortHBar({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4.h,
      width: width ?? 24.w,
      margin:  EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: color ?? context.theme.greyColor!.withOpacity(.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
