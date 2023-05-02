import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/utils/palette.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({Key? key, required this.country}) : super(key: key);
   final Country country;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 40.h,
      width: 40.w,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color:  Palette.greenColor, width: 1.50),
        ),
      ),
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(" +${country.phoneCode} "),
          Text(country.name,overflow: TextOverflow.fade,softWrap: false,maxLines: 1,),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );;
  }
}
