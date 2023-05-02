import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/helper/show_alert_dialog.dart';
import '../../bloc/phone_auth/phone_auth_cubit.dart';

class PinCodeWidget extends StatelessWidget {
   PinCodeWidget({Key? key,}) : super(key: key);

  final TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: <Widget>[
          PinCodeTextField(
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            obscureText: true,
            autoDisposeControllers: false,
            onChanged: (pinCode) {
              if (pinCode.length == 6) {
                _submitSmsCode(context);
              }
            },
            appContext: context,
          ),
          const Text(AppConst.enterYourSixDigitCode)
        ],
      ),
    );
  }

  Future<void> _submitSmsCode(BuildContext context) async {
    if (_pinCodeController.text.isNotEmpty) {
      try {
        await BlocProvider.of<PhoneAuthCubit>(context).submitSmsCode(smsCode: _pinCodeController.text);
      } catch (e) {
        showAlertDialog(context: context, message: e.toString());
      }
    } else {
      showAlertDialog(context: context, message: AppConst.enterValidSMSCode);
    }
  }
}
