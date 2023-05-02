import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';

import '../../../../common/utils/palette.dart';

class SingleItemCallPage extends StatelessWidget {
  const SingleItemCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top: 8.h, right: 8.w, left: 8.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 56.h,
                    width: 56.w,
                    child: ClipRRect(
                      borderRadius:  BorderRadius.all(Radius.circular(24.r)),
                      child: Image.asset(AppConst.profileDefaultImage),
                    ),
                  ),
                   SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text(
                        AppConst.userName,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                       SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.call_received,
                            color:  Palette.primaryColor,
                            size: 18,
                          ),
                          Text(
                            AppConst.yesterday,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Icon(Icons.call,color:  Palette.primaryColor,)
            ],
          ),
           Padding(
            padding: EdgeInsets.only(left: 56.w, right: 8.w),
            child: const Divider(
              thickness: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}
