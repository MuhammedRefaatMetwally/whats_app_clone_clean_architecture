import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import '../../../domain/usecases/get_device_numbers_usecase.dart';


part 'get_device_numbers_state.dart';

class GetDeviceNumbersCubit extends Cubit<GetDeviceNumbersState> {
  final GetDeviceNumberUseCase getDeviceNumberUseCase;


  GetDeviceNumbersCubit(   {required this.getDeviceNumberUseCase,}) : super(GetDeviceNumbersInitial());
 static GetDeviceNumbersCubit i(BuildContext context)=>BlocProvider.of(context);
  Future<void> getDeviceNumbers()async{
    try{
      final  contactNumbers =await getDeviceNumberUseCase.call();
      emit(GetDeviceNumbersLoaded(contacts: contactNumbers));
    }catch(_){
      emit(GetDeviceNumbersFailure());
    }
  }

}
