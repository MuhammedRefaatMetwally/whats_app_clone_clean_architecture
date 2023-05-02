import 'dart:io';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_create_current_user_usecase.dart';
import '../../../domain/usecases/sign_in_with_phone_number_usecase.dart';
import '../../../domain/usecases/verify_phone_number_usecase.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;


  static Country selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode("20");
  String countryCode = selectedFilteredDialogCountry.phoneCode;
  static String phoneNumber="";

  static PhoneAuthCubit i(BuildContext context)=>BlocProvider.of(context);

  void onPickedCountry(Country country){
    selectedFilteredDialogCountry=country;
    countryCode=selectedFilteredDialogCountry.phoneCode;
    emit(CountryDialogPickedCountry(selectedFilteredDialogCountry: country,countryCode:selectedFilteredDialogCountry.phoneCode));
  }
  PhoneAuthCubit({
    required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode({required String smsCode}) async {
    emit(PhoneAuthLoading());
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo({required UserEntity user}) async {

    try {
      await getCreateCurrentUserUseCase.call(UserEntity(
          uid: user.uid,
          name: user.name,
          email: user.email,
          phoneNumber: user.phoneNumber,
          isOnline: user.isOnline,
          profileUrl: user.profileUrl,
          status: user.status));
      emit(PhoneAuthSuccess());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }
}
