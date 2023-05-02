import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';

class NewContactButtonWidget extends StatelessWidget {
  const NewContactButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  color:  Palette.greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: const Icon(
                Icons.person_add,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              AppConst.newContact,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Icon(
          FontAwesomeIcons.qrcode,
          color:  Palette.greenColor,
        )
      ],
    );
  }
}
