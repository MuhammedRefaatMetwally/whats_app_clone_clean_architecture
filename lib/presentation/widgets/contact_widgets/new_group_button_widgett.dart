import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';

class NewGroupButtonWidget extends StatelessWidget {
  const NewGroupButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: const BoxDecoration(
              color:  Palette.greenColor,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: const Icon(
            Icons.people,
            color: Colors.white,
          ),
        ),
         SizedBox(
          width: 14.w,
        ),
         Text(
          AppConst.newGroup,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
