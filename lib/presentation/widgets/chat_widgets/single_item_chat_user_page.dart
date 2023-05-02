import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleItemChatUserPage extends StatelessWidget {
  final String time;
  final String recentSendMessage;
  final String name;
  final String profileUrl;
  const SingleItemChatUserPage(
      { Key? key, required this.time, required this.recentSendMessage, required this.name, required this.profileUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top: 8.h, right: 10.w, left: 10.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileUrl),
                    radius: 32.r,
                  ),
                   SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style:  TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                       SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        recentSendMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
              Text(time)
            ],
          ),
           Padding(
            padding: EdgeInsets.only(left: 64.w, right: 8.w),
            child: const Divider(
              thickness: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}
