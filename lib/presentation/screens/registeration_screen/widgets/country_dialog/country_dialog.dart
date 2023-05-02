import 'package:country_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/data/model/counttry_dialog_model.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import '../../../../../common/utils/palette.dart';
import 'country_dialog_item.dart';

class CountryDialog extends StatelessWidget {
  const CountryDialog({Key? key, required this.dialogModel}) : super(key: key);
  final CountryDialogModel dialogModel;

  static void show({required CountryDialogModel dialogModel}) {
    showDialog(
        context: dialogModel.context,
        builder: (_) => CountryDialog(dialogModel: dialogModel,));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
      builder: (context, state) {
        final cubit=PhoneAuthCubit.i(context);
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor:  Palette.primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.black,
            searchInputDecoration: const InputDecoration(
              hintText: AppConst.search,
            ),
            isSearchable: true,
            title: const Text(AppConst.selectYourPhoneCode),
            onValuePicked:(country) =>cubit.onPickedCountry(country),
            itemBuilder: (country) => CountryItem(country: country,),
          ),
        );
      },
    );
  }
}
