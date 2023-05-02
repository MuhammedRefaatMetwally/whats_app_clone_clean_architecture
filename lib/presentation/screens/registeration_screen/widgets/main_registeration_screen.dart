import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/registeration_screen/widgets/country_dialog/country_dialog_item.dart';
import '../../../../common/helper/show_alert_dialog.dart';
import '../../../../common/utils/palette.dart';
import '../../../../data/model/counttry_dialog_model.dart';
import '../../../bloc/phone_auth/phone_auth_cubit.dart';
import 'country_dialog/country_dialog.dart';

class MainRegistrationScreen extends StatefulWidget {
  const MainRegistrationScreen({
    Key? key,
    required phoneNumber,
  }) : super(key: key);

  @override
  State<MainRegistrationScreen> createState() => _MainRegistrationScreenState();
}

class _MainRegistrationScreenState extends State<MainRegistrationScreen> {
  final TextEditingController _phoneAuthController = TextEditingController();

  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) async {},
      builder: (context, state) {
        final cubit = PhoneAuthCubit.i(context);
        return Scaffold(
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(AppConst.emptyText),
                      Text(
                       AppConst.verifyPhoneNumber,
                        style: TextStyle(
                            fontSize: 18,
                            color:  Palette.greenColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.more_vert)
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    AppConst.whatsDescription,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ListTile(
                    onTap: () => CountryDialog.show(
                      dialogModel: CountryDialogModel(
                        context: context,
                        selectedFilteredDialogCountry:
                            PhoneAuthCubit.selectedFilteredDialogCountry,
                        countryCode: cubit.countryCode,
                      ),
                    ),
                    title: CountryItem(
                      country: PhoneAuthCubit.selectedFilteredDialogCountry,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1.50,
                          color:  Palette.greenColor,
                        ))),
                        width: 48,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                            "+${PhoneAuthCubit.selectedFilteredDialogCountry.phoneCode}"),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _phoneAuthController,
                            decoration: const InputDecoration(
                              hintText: AppConst.phoneNumber,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        color:  Palette.greenColor,
                        onPressed: () => _submitVerifyPhoneNumber(context),
                        child: const Text(
                          AppConst.next,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _submitVerifyPhoneNumber(BuildContext ctx) async {
    if (_phoneAuthController.text.isNotEmpty &&
        int.tryParse(_phoneAuthController.text) != null) {
      try {

        PhoneAuthCubit.phoneNumber =
            "+${BlocProvider.of<PhoneAuthCubit>(context).countryCode}${_phoneAuthController.text}";

        await BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
          phoneNumber: PhoneAuthCubit.phoneNumber
        );
      } catch (e) {
        showAlertDialog(context: context, message: e.toString());
      }
    } else {
      showAlertDialog(context: context, message: AppConst.enterYourPhoneNumber);
    }
  }
}
