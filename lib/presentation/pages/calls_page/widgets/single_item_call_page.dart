import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';

import '../../../../common/utils/palette.dart';

class SingleItemCallPage extends StatelessWidget {
  const SingleItemCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Image.asset(AppConst.profileDefaultImage),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        AppConst.userName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
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
          const Padding(
            padding: EdgeInsets.only(left: 56, right: 8),
            child: Divider(
              thickness: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}
