import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/get_status.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/upload_status.dart';

import '../../../data/model/status_model.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit({required this.uploadStatusUseCase,required this.getStatusUseCase}) : super(StatusInitial());
  final UploadStatusUseCase uploadStatusUseCase;
  final GetStatusUseCase getStatusUseCase;

  Future<void> uploadStatus({
    required String userName,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
  })async{
    try{
      return await uploadStatusUseCase.call(userName: userName, profilePic: profilePic, phoneNumber: phoneNumber, statusImage: statusImage);
    }on SocketException catch (_){
      emit(StatusFailure());
    }catch(_){
      emit(StatusFailure());
    }
  }

  Future<List<Status>> getStatus()async{
    emit(StatusLoading());
    final status=await  getStatusUseCase.call();
    try{
      emit(StatusLoaded(status: status));
    }on SocketException catch(e){
      emit(StatusFailure());
    }catch(e){
      emit(StatusFailure());
    }
    return   status;
  }
}
