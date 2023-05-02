import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../common/utils/palette.dart';
import '../../screens/home_screen/widgets/custom_tab_bar_button.dart';

class CustomTabBar extends StatelessWidget {
  final int? index;

  const CustomTabBar({ Key? key,  this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: const BoxDecoration(color:  Palette.primaryColor),
      child: Row(
        children: <Widget>[
           SizedBox(
            width: 40.w,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: AppConst.chatTAB,
              textColor: index == 1 ? Palette.textIconColor :  Palette.textIconColorGray!,
              borderColor: index == 1 ?  Palette.textIconColor : Colors.transparent,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: AppConst.statusTAB,
              textColor: index == 2 ?  Palette.textIconColor :  Palette.textIconColorGray!,
              borderColor: index == 2 ?  Palette.textIconColor : Colors.transparent,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: AppConst.callsTAB,
              textColor: index == 3 ?  Palette.textIconColor :  Palette.textIconColorGray!,
              borderColor: index == 3 ?  Palette.textIconColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}


