part of 'group_cubit.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}
class GroupLoading extends GroupState {}
class GroupLoaded extends GroupState {
  List<Group> groups=[];

  GroupLoaded({required this.groups});
}
class GroupFailure extends GroupState {}
