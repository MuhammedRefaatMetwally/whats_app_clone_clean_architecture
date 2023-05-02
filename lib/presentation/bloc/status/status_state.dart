part of 'status_cubit.dart';

@immutable
abstract class StatusState extends Equatable{
  @override
  List<Object?> get props => [];
}

class StatusInitial extends StatusState {}
class StatusLoading extends StatusState {}
class StatusLoaded extends StatusState {
  List<Status> status;

  StatusLoaded({required this.status});

  @override
  List<Object?> get props => [status];
}
class StatusFailure extends StatusState {}
