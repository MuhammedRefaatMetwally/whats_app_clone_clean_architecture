import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 156.h,
          width: 156.w,
          decoration: BoxDecoration(
            color:  Palette.greenColor.withOpacity(.4),
            borderRadius:  BorderRadius.all(Radius.circular(96.r)),
          ),
          child: Icon(
            Icons.message,
            color: Colors.white.withOpacity(.6),
            size: 40,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(AppConst.startChatting,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(.4)),
            ),
          ),
        ),
      ],
    );
  }
}
