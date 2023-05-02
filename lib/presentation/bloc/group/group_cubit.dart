import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whats_app_clone_clean_arch/data/model/group.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/create_group.dart';
import 'package:whats_app_clone_clean_arch/domain/usecases/get_group_usecase.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {

  GroupCubit(
      {required this.createGroupUseCase, required this.getChatGroupUseCase})
      : super(GroupInitial());

  final CreateGroupUseCase createGroupUseCase;
  final GetChatGroupUseCase getChatGroupUseCase;

  void createGroup(
      {required String name,
      required File profilePic,
      required List<Contact> selectedContact}) async {
    try {
      await createGroupUseCase.call(
          name: name, profilePic: profilePic, selectedContact: selectedContact);
    } on SocketException catch (e) {
      emit(GroupFailure());
    } catch (e) {
      emit(GroupFailure());
    }
  }
  void getChatGroup() {
    try{
      getChatGroupUseCase.call().listen((event) {
       emit(GroupLoaded(groups: event));
     });
    }on SocketException catch(e){
      emit(GroupFailure());
    }catch(e){
      emit(GroupFailure());
    }
  }
}
