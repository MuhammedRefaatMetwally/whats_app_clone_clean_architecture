import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';

import '../../../../common/utils/palette.dart';

class NewGroupButtonWidget extends StatelessWidget {
  const NewGroupButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
              color:  Palette.greenColor,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: const Icon(
            Icons.people,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        const Text(
          AppConst.newGroup,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
