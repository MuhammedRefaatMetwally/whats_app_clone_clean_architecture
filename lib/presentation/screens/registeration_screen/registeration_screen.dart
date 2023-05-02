import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/screens/registeration_screen/widgets/main_registeration_screen.dart';
import '../../../common/utils/palette.dart';
import '../../../data/model/user_model.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/phone_auth/phone_auth_cubit.dart';
import '../../bloc/user/user_cubit.dart';
import '../../pages/phone_veriffication_page/phone_verification_page.dart';
import '../../pages/user_information_page/user_informtion_screen.dart';
import '../home_screen/home_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, phoneAuthState) {
            if (phoneAuthState is PhoneAuthSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (phoneAuthState is PhoneAuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(AppConst.somethingIsWrong),
                      Icon(Icons.error_outline)
                    ],
                  ),
                ),
              ));
            }
          },
          builder: (context, phoneAuthState) {
            if (phoneAuthState is PhoneAuthSmsCodeReceived) {
              return const PhoneVerificationPage();
            }
            if (phoneAuthState is PhoneAuthProfileInfo) {
              return UserInformationScreen(
                phoneNumber: PhoneAuthCubit.phoneNumber,
              );
            }
            if (phoneAuthState is PhoneAuthLoading) {
              return  const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color:  Palette.greenColor,),
                ),
              );
            }
            if (phoneAuthState is PhoneAuthSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return BlocBuilder<UserCubit, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoaded) {
                         final currentUserInfo = userState.users.firstWhere(
                                  (user) => user.uid == authState.uid,
                              orElse: () =>  UserModel());
                          return HomeScreen(userInfo: currentUserInfo);
                        }
                        return Container();
                      },
                    );
                  }
                  return Container();
                },
              );
            }
            return MainRegistrationScreen(phoneNumber: PhoneAuthCubit.phoneNumber);
          },
        ),
      ),
    );
  }
}